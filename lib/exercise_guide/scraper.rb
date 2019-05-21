class ExerciseGuide::Scraper

    def self.scrape_body_parts
      doc = Nokogiri::HTML(open("https://www.bodybuilding.com/exercises/"))
      array = doc.css("div.exercise-list li")

      array.each do |muscle|
        attributes = {
          name: muscle.css("a").children.text,
          body_part_link: muscle.css("a").attribute("href").value
        }
        ExerciseGuide::BodyPart.new(attributes)
      end
    end

    def self.scrape_exercises
      doc = Nokogiri::HTML(open("https://www.bodybuilding.com/exercises/muscle/neck"))
      array = doc.css("div.ExResult-row")

      array.each do |exercise|
        attributes = {
          exercise_title: exercise.css(".ExHeading").text.strip.gsub(/\s+/,' '),
          equipment_type: exercise.css(".ExResult-equipmentType").text.strip.gsub(/\s+/,' '),
          rating: exercise.css(".ExRating-badge").text.strip.gsub(/\s+/,' '),
          link: exercise.css("a").attribute("href").value.strip.gsub(/\s+/,' ')
        }
        ExerciseGuide::Exercise.new(attributes)
      end
    end

    def self.scrape_instructions
      doc = Nokogiri::HTML(open("https://www.bodybuilding.com/exercises/lying-face-down-plate-neck-resistance"))
      array = doc.css("div.flexo-container")

      array.each do |instructions|
        attributes = {
        #  title:
          instructions: instructions.css('.ExDetail-descriptionSteps li').text.strip.gsub(/\s+/,' ')
        #  video:
        }
        ExerciseGuide::Instructions.new(attributes)
      end
    end

end

# ExerciseGuide::Scraper.scrape_body_parts
# ExerciseGuide::Scraper.scrape_exercises
# ExerciseGuide::Scraper.scrape_instructions
