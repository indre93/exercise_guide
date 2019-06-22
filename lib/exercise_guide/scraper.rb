class ExerciseGuide::Scraper

  def self.scrape_muscles
    doc = Nokogiri::HTML(open("https://www.bodybuilding.com/exercises/"))
    array_of_muscles = doc.css("div.exercise-list li")

    array_of_muscles.collect do |muscle|
      attributes = {
        name: muscle.css("a").children.text,
        muscles_link: "https://www.bodybuilding.com" + muscle.css("a").attribute("href").value
      }
      ExerciseGuide::Muscle.new(attributes)
    end
  end

  def self.scrape_exercises(muscle)
    doc = Nokogiri::HTML(open(muscle.muscles_link))
    array_of_exercises = doc.css("div.ExResult-row")

    array_of_exercises.collect do |exercise|
      attributes = {
        exercise_title: exercise.css(".ExHeading").text.strip,
        exercise_rating: exercise.css(".ExRating-badge").text.strip,
        exercises_link: "https://www.bodybuilding.com" + exercise.css("a").attribute("href").value.strip
      }
      exercise = ExerciseGuide::Exercise.new(attributes)
      # associates Muscle and Exercise / Muscle has many exercises
      muscle.exercises << exercise unless muscle.exercises.include?(exercise)
      exercise.muscle = muscle # belongs to relationship
    end
  end

  def self.scrape_instructions(exercise)
    doc = Nokogiri::HTML(open(exercise.exercises_link))
    array = doc.css("div.ExDetail")

    array.collect do |instructions|
      attributes = {
        title: instructions.css(".ExHeading--h2").text.strip,
        type: instructions.css(".bb-list--plain a")[0].text.strip,
        muscle_worked:instructions.css(".bb-list--plain a")[1].text.strip,
        equipment: instructions.css(".bb-list--plain a")[2].text.strip,
        video_link: instructions.css('.grid-6').children.css("div").at_css("div").values[3],
        instructions: instructions.css(".ExDetail-descriptionSteps").children.map {|step| step.text}
      }
      instructions = ExerciseGuide::Instructions.new(attributes)
      instructions.exercise = exercise # belongs to relationship / Instructions belongs to Exercise
    end
  end

end
