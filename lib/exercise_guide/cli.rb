class ExerciseGuide::CLI

  def start
    puts "Welcome to the Exercise Guide App!"
    puts "Type the number of the muscle that you would like to exercise"
    puts "            -----------------"
    ExerciseGuide::Scraper.scrape_body_parts
    list_body_parts
    puts "            -----------------"
    puts "            Exercise results"
    puts ""
    ExerciseGuide::Scraper.scrape_exercises
    list_exercises
    puts "            -----------------"
    ExerciseGuide::Scraper.scrape_instructions
    puts "            Instructions"
    exercise_instructions
    puts ""
    puts "            -----------------"
  end

  def list_body_parts
    ExerciseGuide::BodyPart.all.each.with_index(1) do |body_part, index, rating|
      puts "#{index}. #{body_part.name}"
    end
  end

  def body_part_url
    ExerciseGuide::BodyPart.all.each do |body_part|
      puts "#{body_part.body_part_link}"
    end
  end

  def list_exercises
    ExerciseGuide::Exercise.all.each.with_index(1) do |exercise, index|
      puts "#{index}. #{exercise.exercise_title}"
      puts "   Rating: #{exercise.rating}"
      puts "   #{exercise.equipment_type}"
      puts ""
    end
  end

  def exercise_instructions
    ExerciseGuide::Instructions.all.each do |exercise|
      puts "#{exercise.instructions}"
    end
  end


end
