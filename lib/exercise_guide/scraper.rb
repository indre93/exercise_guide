class ExerciseGuide::Scraper

  def scrape_muscles
    doc = Nokogiri::HTML(open("https://www.bodybuilding.com/exercises/"))
    muscles_array = doc.css("div.exercise-list li")

    muscles_array.each do |muscle|
      attributes = {
        name: muscle.css("a").children.text,
        muscles_link: "https://www.bodybuilding.com" + muscle.css("a").attribute("href").value
      }
      ExerciseGuide::Muscle.new(attributes)
    end
  end

  def scrape_exercises(muscle)
    doc = Nokogiri::HTML(open(muscle.muscles_link))
    exercises_array = doc.css("div.ExResult-row")

    exercises_array.each do |exercise|
      attributes = {
        exercise_title: exercise.css(".ExHeading").text.strip,
        exercise_rating: exercise.css(".ExRating-badge").text.strip,
        exercises_link: "https://www.bodybuilding.com" + exercise.css("a").attribute("href").value.strip
      }
      ExerciseGuide::Exercise.new(attributes)
    end
  end

  def scrape_instructions(exercise)
    doc = Nokogiri::HTML(open(exercise.exercises_link))
    instruction_details = doc.css("div.ExDetail")

    instruction_details.each do |instructions|
      attributes = {
        title: instructions.css(".ExHeading--h2").text.strip,
        type: instructions.css(".bb-list--plain a")[0].text.strip,
        muscle_worked:instructions.css(".bb-list--plain a")[1].text.strip,
        equipment: instructions.css(".bb-list--plain a")[2].text.strip,
        video_link: instructions.css('.grid-6').children.css("div").at_css("div").values[3],
        instructions: instructions.css(".ExDetail-descriptionSteps").children.map {|step| step.text.strip} # returns array to list instructions instead of paragraph
      }
      ExerciseGuide::Instructions.new(attributes)
    end
  end

end
