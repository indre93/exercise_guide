class ExerciseGuide::CLI

  def start
    puts ""
    puts "     ----------------------------------".colorize(:yellow)
    puts "     Welcome to the Exercise Guide App!".colorize(:yellow)
    puts "     ----------------------------------".colorize(:yellow)
    puts ""
    ExerciseGuide::Scraper.scrape_body_parts
    list_body_parts
    puts ""
    puts " Type the number of the muscle that you would like to exercise:"
    #gets input and lists exercises based on input
    puts ""
    puts "           ------------------".colorize(:yellow)
    puts "            Exercise results".colorize(:yellow)
    puts "           ------------------".colorize(:yellow)
    puts ""
    puts "    =========================================".colorize(:red)
    ExerciseGuide::Scraper.scrape_exercises
    list_exercises
    puts ""
    puts " Type the number of the exercise for instructions:"
    #gets input and shows exercise instructions based in input
    puts ""
    puts "             --------------".colorize(:yellow)
    puts "              Instructions".colorize(:yellow)
    puts "             --------------".colorize(:yellow)
    ExerciseGuide::Scraper.scrape_instructions
    exercise_instructions
    puts ""
    puts "            -----------------".colorize(:yellow)
  end

  def list_body_parts
    ExerciseGuide::BodyPart.all.each.with_index(1) do |body_part, index, rating|
      puts " #{index}. #{body_part.name}"
    end
  end

  def body_part_url
    ExerciseGuide::BodyPart.all.each do |body_part|
      puts " #{body_part.body_part_link}"
    end
  end

  def list_exercises
    ExerciseGuide::Exercise.all.each.with_index(1) do |exercise, index|
      puts " #{index}. #{exercise.exercise_title}"
      puts "    Rating: #{exercise.rating}"
      puts "    #{exercise.equipment_type}"
      puts "    =========================================".colorize(:red)
    end
  end

  def exercise_instructions
    ExerciseGuide::Instructions.all.each do |exercise|
      puts "    #{exercise.title}"
      puts ""
      puts "#{exercise.instructions}"
      puts ""
      puts "Click on the link to watch this exercise! ===> #{exercise.video.colorize(:blue)}"
    end
  end


end
