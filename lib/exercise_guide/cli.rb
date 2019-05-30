class ExerciseGuide::CLI

  def start
    puts ""
    puts "     -----------------------------------".colorize(:yellow)
    puts "      Welcome to the Exercise Guide App!".colorize(:yellow)
    puts "     -----------------------------------".colorize(:yellow)
    puts ""
    list_muscles_method
    get_muscle_method # gets input for muscle selected
    list_exercises_method # list exercises that corresponds to muscle selected
    get_exercise_method # gets input for exercise seleted for instructions
    exercise_instructions_method # puts instructions for exercise selected
    end_menu
  end

  # lists all muscles
  def list_muscles_method
    ExerciseGuide::Scraper.scrape_muscles
    ExerciseGuide::Muscle.all.each.with_index(1) do |muscle, index|
      puts "#{index}. #{muscle.name}"
    end
  end

  # gets input for muscle selected
  def get_muscle_method
    puts ""
    puts "==> Please type the number of the body part that you would like to exercise:".colorize(:green)
    puts ""
    input = gets.strip
    index = input.to_i - 1 # So we can get a number that is useful in an array
    if index.between?(0,17)
      muscle = ExerciseGuide::Muscle.all[index]
      ExerciseGuide::Scraper.scrape_exercises(muscle)
    else
      puts "Oops! invalid input, please try again.".colorize(:red)
      get_muscle_method
    end
  end

  # list exercises that corresponds to muscle selected
  def list_exercises_method
    puts "           ------------------".colorize(:yellow)
    puts "            Exercise results".colorize(:yellow)
    puts "           ------------------".colorize(:yellow)
    puts "   *************************************"
    ExerciseGuide::Exercise.all.each.with_index(1) do |exercise, index|
      puts "#{index}. #{exercise.exercise_title}"
      puts "   Rating: #{exercise.exercise_rating}"
      puts "   #{exercise.equipment_type}"
      puts "   *************************************"
    end
  end

  # gets input for exercise seleted for instructions
  def get_exercise_method
    puts ""
    puts "==> Please type the number of the exercise for instructions:".colorize(:green)
    puts ""
    input = gets.strip
    index = input.to_i - 1 # So we can get a number that is useful in an array
    if index.between?(0,17)
      exercise = ExerciseGuide::Exercise.all[index]
      ExerciseGuide::Scraper.scrape_instructions(exercise)
    else
      puts "Oops! invalid input, please try again.".colorize(:red)
      get_exercise_method
    end
  end

  def exercise_instructions_method
    puts "             --------------".colorize(:yellow)
    puts "              Instructions".colorize(:yellow)
    puts "             --------------".colorize(:yellow)
    ExerciseGuide::Instructions.all.each do |exercise|
      puts "________#{exercise.title}_________".colorize(:yellow)
      puts ""
      puts " #{exercise.instructions}"
      puts ""
      puts "Click on the link to watch this exercise! ===> #{exercise.video_link.colorize(:blue)}"
      puts ""
    end
  end

  def end_menu
    puts " Type:".colorize(:green)
    puts " 1. To go back to exercise results to try a different exercise".colorize(:green)
    puts " 2. To start over".colorize(:green)
    puts " 3. To Exit".colorize(:green)
    puts ""

    input = gets.strip
    index = input.to_i - 1 # So we can get a number that is useful in an array
    case input
    when "1"
      ExerciseGuide::Instructions.destroy_all
      list_exercises_method
      get_exercise_method
      exercise_instructions_method
      end_menu
    when "2"
      ExerciseGuide::Muscle.destroy_all
      ExerciseGuide::Exercise.destroy_all
      ExerciseGuide::Instructions.destroy_all
      ExerciseGuide::CLI.new.start
    when "3"
      puts "See you next time!!"
      puts ""
      exit
    else
      puts "Oops! invalid input, please try again.".colorize(:red)
    end_menu
    end
  end

end
