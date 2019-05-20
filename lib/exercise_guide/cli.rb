class ExerciseGuide::CLI

  def start
    puts "Welcome to the Exercise Guide App!"
    puts "Type the muscle that you would like to exercise"
    puts "            -----------------"
    ExerciseGuide::Scraper.scrape_body_parts
    list_body_parts
    puts "            -----------------"
    #gets input

    #puts "Type the exercise for more details"
    #puts description and link for video
  end

  def list_body_parts
    ExerciseGuide::BodyPart.all.each.with_index(1) do |body_part, index|
      puts "#{index}. #{body_part.name}"
    end
  end

  def list_exercises
    #lists all exercises for that body part
    ExerciseGuide::Exercise.all.each.with_index(1) do |exercise, index|
      puts "#{index}. #{exercise.name}"
    end

  end


end
