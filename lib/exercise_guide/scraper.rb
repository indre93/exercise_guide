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
        exercise_title: exercise.css(".ExHeading").text.strip,
        equipment_type: exercise.css(".ExResult-equipmentType").text.strip.gsub(/\s+/,' '),
        rating: exercise.css(".ExRating-badge").text.strip,
        link: exercise.css("a").attribute("href").value.strip.gsub(/\s+/,' ')
      }
      ExerciseGuide::Exercise.new(attributes)
    end
  end

  def self.scrape_instructions
    doc = Nokogiri::HTML(open("https://www.bodybuilding.com/exercises/side-laterals-to-front-raise-"))
    array = doc.css("div.ExDetail")

    array.each do |instructions|
      attributes = {
        title: instructions.css(".ExHeading--h2").text.strip.gsub(/\s+/,' '),
        instructions: instructions.css(".ExDetail-descriptionSteps li").text.strip.gsub(/\s+/,' '),
        video: instructions.css('.grid-6').children.css("div").at_css("div").values[3]
      }
      ExerciseGuide::Instructions.new(attributes)
    end
  end

end

# ExerciseGuide::Scraper.scrape_body_parts
# ExerciseGuide::Scraper.scrape_exercises
# ExerciseGuide::Scraper.scrape_instructions
