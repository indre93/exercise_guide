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
      ExerciseGuide::Scraper.scrape_exercises(muscle)
      list_exercises # list exercises that corresponds
    elsif input == "exit"
      # allow this method to end
    else
      puts "Oops! invalid input, please try again."
      get_muscle_method
    end
  end

  def list_exercises
    puts "           ------------------".colorize(:yellow)
    puts "            Exercise results".colorize(:yellow)
    puts "           ------------------".colorize(:yellow)
    puts "   *************************************"
    ExerciseGuide::Exercise.all.each.with_index(1) do |exercise, index|
      puts "#{index}. #{exercise.exercise_title}"
      puts "   Rating: #{exercise.rating}"
      puts "   #{exercise.equipment_type}"
      puts "   *************************************"
    end
    puts ""
    puts "==> Please type the number of the exercise for instructions:"
    puts "==> Type EXIT to exit or START to start over.".colorize(:red)
    get_exercise_method
  end

  def get_exercise_method
    input = gets.strip
    index = input.to_i - 1 # So we can get a number that is useful in an array
    if index.between?(0,17)
      exercise = ExerciseGuide::Exercise.all[index]
      ExerciseGuide::Scraper.scrape_instructions(exercise)
      exercise_instructions # list exercises that corresponds
    elsif input == "exit" # allow this method to end
    else
      puts "Oops! invalid input, please try again."
      get_exercise_method
    end
  end

  def exercise_instructions
    puts "             --------------".colorize(:yellow)
    puts "              Instructions".colorize(:yellow)
    puts "             --------------".colorize(:yellow)
    ExerciseGuide::Instructions.all.each do |exercise|
      puts "________#{exercise.title}_________"
      puts ""
      puts "#{exercise.instructions}"
      puts ""
      puts "Click on the link to watch this exercise! ===> #{exercise.video.colorize(:blue)}"
      puts "==> Type EXIT to exit or START to start over.".colorize(:red)
    end
  end

end
