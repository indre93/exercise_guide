class ExerciseGuide::CLI

  def start
    puts ""
    puts "     ----------------------------------".colorize(:yellow)
    puts "     Welcome to the Exercise Guide App!".colorize(:yellow)
    puts "     ----------------------------------".colorize(:yellow)
    puts ""
    ExerciseGuide::Scraper.scrape_muscles
    list_muscles
    get_muscle_method
    #gets input and lists exercises based on input
    puts ""
    puts "           ------------------".colorize(:yellow)
    puts "            Exercise results".colorize(:yellow)
    puts "           ------------------".colorize(:yellow)
    ExerciseGuide::Scraper.scrape_exercises(muscle)
    list_exercises
    get_exercise_method
    puts ""
    puts "==> Type EXIT to quit or START to start over.".colorize(:red)
    #gets input and shows exercise instructions based in input
    puts ""
    puts "             --------------".colorize(:yellow)
    puts "              Instructions".colorize(:yellow)
    puts "             --------------".colorize(:yellow)
    ExerciseGuide::Scraper.scrape_instructions
    exercise_instructions
    puts ""
    puts "==> Type EXIT to quit or START to start over.".colorize(:red)
    puts ""
  end



  def list_muscles
    puts "==> Please type the number of the body part that you would like to exercise:"
    puts ""
    ExerciseGuide::Muscle.all.each.with_index(1) do |muscle, index|
      puts "#{index}. #{muscle.name}"
    end
  end



  def get_muscle_method
    input = gets.strip
    index = input.to_i - 1 # So we can get a number that is useful in an array
    if index.between?(0,17)
      muscle = ExerciseGuide::Muscle.all[index]
      puts ""
      puts "#{muscle.name}"
      list_exercises
      ExerciseGuide::Scraper.scrape_exercises(muscle)
        # list exercises that corresponds
    elsif input == "exit"
      # allow this method to end
    else
      puts "Oops! invalid input, please try again."
      get_body_part_method
    end
  end

  def list_exercises
    puts "   *************************************"
    ExerciseGuide::Exercise.all.each.with_index(1) do |exercise, index|
      puts "#{index}. #{exercise.exercise_title}"
      puts "   Rating: #{exercise.rating}"
      puts "   #{exercise.equipment_type}"
      puts "   *************************************"
    end
    puts ""
    puts "==> Please type the number of the exercise for instructions:"

  end

  def get_exercise_method

  end

  def exercise_instructions
    ExerciseGuide::Instructions.all.each do |exercise|
      puts "#{exercise.instructions}"
      puts ""
      puts "Click on the link to watch this exercise! ===> #{exercise.video.colorize(:blue)}"
    end
  end

end
