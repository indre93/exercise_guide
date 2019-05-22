class ExerciseGuide::Scraper

  def self.scrape_muscles
    doc = Nokogiri::HTML(open("https://www.bodybuilding.com/exercises/"))
    array_of_muscles = doc.css("div.exercise-list li")

    array_of_muscles.each do |muscle|
      attributes = {
        name: muscle.css("a").children.text,
        muscle_link: "https://www.bodybuilding.com" + muscle.css("a").attribute("href").value
      }
      ExerciseGuide::Muscle.new(attributes)
    end
  end

  def self.scrape_exercises(muscle = ExerciseGuide::Muscle.new)
    doc = Nokogiri::HTML(open(muscle.muscle_link))
    array_of_exercises = doc.css("div.ExResult-row")

    array_of_exercises.each do |exercise|
      attributes = {
        exercise_title: exercise.css(".ExHeading").text.strip,
        equipment_type: exercise.css(".ExResult-equipmentType").text.strip.gsub(/\s+/,' '),
        rating: exercise.css(".ExRating-badge").text.strip,
        link: "https://www.bodybuilding.com" + exercise.css("a").attribute("href").value.strip
      }
      ExerciseGuide::Exercise.new(attributes)
    end
  end

  def self.scrape_instructions(exercise = ExerciseGuide::Exercise.new)
    doc = Nokogiri::HTML(open(exercise.link))
    array = doc.css("div.ExDetail")

    array.each do |instructions|
      attributes = {
        title: instructions.css(".ExHeading--h2").text.strip,
        instructions: instructions.css(".ExDetail-descriptionSteps li").text.strip,
        video: instructions.css('.grid-6').children.css("div").at_css("div").values[3]
      }
      ExerciseGuide::Instructions.new(attributes)
    end
  end

end
