class ExerciseGuide::CLI

  def start
    puts ""
    puts "     -----------------------------------"
    puts "      Welcome to the Exercise Guide App!"
    puts "     -----------------------------------"
    puts ""

    list_muscles
    get_muscle
    list_exercises
    get_exercise
    exercise_instructions
    end_menu
  end

  # lists all muscles
  def list_muscles
    ExerciseGuide::Scraper.scrape_muscles
    ExerciseGuide::Muscle.all.each.with_index(1) do |muscle, index|
      puts "#{index}. #{muscle.name}"
    end
  end

  # gets input for muscle selected
  def get_muscle
    puts ""
    puts "==> Please type the number of the body part that you would like to exercise:"
    puts ""

    input = gets.strip
    index = input.to_i - 1 # So we can get a number that is useful in an array

    if index <= ExerciseGuide::Muscle.all.size
      muscle = ExerciseGuide::Muscle.all[index]
      ExerciseGuide::Scraper.scrape_exercises(muscle)
    else
      puts "Oops! invalid input, please try again."
      get_muscle
    end
  end

  # list exercises that corresponds to muscle selected
  def list_exercises
    puts "           ------------------"
    puts "            Exercise results"
    puts "           ------------------"
    puts "   *************************************"

    ExerciseGuide::Exercise.all.each.with_index(1) do |exercise, index|
      puts "#{index}. #{exercise.exercise_title}"
      puts "   Rating: #{exercise.exercise_rating}"
      puts "   #{exercise.equipment_type}"
      puts "   *************************************"
    end
  end

  # gets input for exercise seleted for instructions
  def get_exercise
    puts ""
    puts "==> Please type the number of the exercise for instructions:"
    puts ""

    input = gets.strip
    index = input.to_i - 1 # So we can get a number that is useful in an array

    if index <= ExerciseGuide::Exercise.all.size
      exercise = ExerciseGuide::Exercise.all[index]
      ExerciseGuide::Scraper.scrape_instructions(exercise)
    else
      puts "Oops! invalid input, please try again."
      get_exercise
    end
  end

  # puts instructions for exercise selected
  def exercise_instructions
    puts "             --------------"
    puts "              Instructions"
    puts "             --------------"

    ExerciseGuide::Instructions.all.each do |exercise|
      puts "________#{exercise.title}_________"
      puts ""
      puts " #{exercise.instructions}"
      puts ""
      puts "Click on the link to watch this exercise! ===> #{exercise.video_link}"
    end
  end

  def stat_over
    ExerciseGuide::Muscle.destroy_all
    ExerciseGuide::Exercise.destroy_all
    ExerciseGuide::Instructions.destroy_all
    ExerciseGuide::CLI.new.start
  end

  def exercise_results_menu
    ExerciseGuide::Instructions.destroy_all
    list_exercises
    get_exercise
    exercise_instructions
    end_menu
  end

  def end_menu
    puts ""
    puts " Type:"
    puts " 1. To go back to exercise results to try a different exercise"
    puts " 2. To start over"
    puts " 3. To Exit"
    puts ""

    case input = gets.strip
    when "1"
      exercise_results_menu
    when "2"
      ExerciseGuide::CLI.new.start
    when "3"
      puts "See you next time!!"
      puts ""
      exit
    else
      puts "Oops! invalid input, please try again."
    end_menu
    end
  end

end
