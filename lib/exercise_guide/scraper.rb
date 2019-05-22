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

  def self.scrape_exercises(muscle)
    doc = Nokogiri::HTML(muscle.muscle_link)
    array_of_exercises = doc.css("div.ExResult-row")

    array_of_exercises.each do |exercise|
      #instantiate a new exercise
      eo = ExerciseGuide::Exercise.new
      #associate exercise to body part

      eo.exercise_title = exercise.css(".ExHeading").text.strip
      eo.equipment_type = exercise.css(".ExResult-equipmentType").text.strip.gsub(/\s+/,' ')
      eo.rating = exercise.css(".ExRating-badge").text.strip
      eo.link = "https://www.bodybuilding.com" + exercise.css("a").attribute("href").value.strip

      #add this review to body_part.exercises
      muscle.add_exercise(eo)
    end
  end

  # Need to open "exercise.link" instead of below link used
  # Associate instructions with exercise
  # Add this instruction to exercise.instructions
  def self.scrape_instructions
    doc = Nokogiri::HTML(open("https://www.bodybuilding.com/exercises/side-laterals-to-front-raise-"))
    array = doc.css("div.ExDetail")

    array.each do |instructions|
      attributes = {
        instructions: instructions.css(".ExDetail-descriptionSteps li").text.strip,
        video: instructions.css('.grid-6').children.css("div").at_css("div").values[3]
      }
      ExerciseGuide::Instructions.new(attributes)
    end
  end

end
