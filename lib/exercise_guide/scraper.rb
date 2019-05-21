class ExerciseGuide::Scraper

    def self.scrape_body_parts
      doc = Nokogiri::HTML(open("https://www.bodybuilding.com/exercises/"))

      array_body_parts = doc.css("div.exercise-list li")
      array_body_parts.each do |muscle|
        attributes = {
          name: muscle.css("a").children.text,
          body_part_url: muscle.css("a").attribute("href").value
        }

        ExerciseGuide::BodyPart.new(attributes)
      end
    end

    def self.scrape_exercises
      doc = Nokogiri::HTML(open("https://www.bodybuilding.com/exercises/muscle/neck"))
      list = doc.css("div.ExResult-row")
      list.each do |exercise|
        hash = {
          exercise_title: exercise.css(".ExHeading").text.strip.gsub(/\s+/,' '),
          equipment_type: exercise.css(".ExResult-equipmentType").text.strip.gsub(/\s+/,' '),
          rating: exercise.css(".ExRating-badge").text.strip.gsub(/\s+/,' '),
          link: exercise.css("a").attribute("href").value.strip.gsub(/\s+/,' ')
        }
        ExerciseGuide::Exercise.new(hash)
      end
    end

    def self.scrape_exercise
      # shows exercise selected and includes description

      # title of the exercise ==> :exercise_title
      # equipment type, either "body only" or "other" ==> :equipment_type
      # rating for exercise ==> :rating
      # instructions for exercise ==> :instructions
      # video example or pics of exercise ==>
    end

end

# ExerciseGuide::Scraper.scrape_body_parts
# ExerciseGuide::Scraper.scrape_exercises
# ExerciseGuide::Scraper.scrape_exercises
