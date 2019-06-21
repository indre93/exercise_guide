require 'colorize'

class ExerciseGuide::CLI

  def start
    puts ""
    puts "     " + "-------------------------------------------".colorize(:color => :black, :background => :yellow)
    puts "         Welcome to the Exercise Guide App!".colorize(:yellow)
    puts "     " + "-------------------------------------------".colorize(:color => :black, :background => :yellow)
    puts ""
    puts " Learn different exercises based on the muscle you would like to work on!".colorize(:yellow)
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
      puts " (#{index}) #{muscle.name.colorize(:cyan)}"
    end
  end

  # gets input for muscle selected
  def get_muscle
    puts ""
    puts "---> Please type the number of the muscle that you would like to exercise:".colorize(:yellow)
    puts "---> Or type EXIT to exit".colorize(:red)
    puts ""

    input = gets.strip
    index = input.to_i - 1 # So we can get a number that is useful in an array

    if input == "exit" || input == "EXIT"
      end_app
    elsif index <= ExerciseGuide::Muscle.all.size
      muscle = ExerciseGuide::Muscle.all[index]
      ExerciseGuide::Scraper.scrape_exercises(muscle)
    else
      puts "Oops! invalid input, please try again.".colorize(:red)
      get_muscle
    end
  end

  # list exercises that corresponds to muscle selected
  def list_exercises
    puts "          " + "--------------------".colorize(:color => :black, :background => :yellow)
    puts "            Exercise results".colorize(:yellow)
    puts "          " + "--------------------".colorize(:color => :black, :background => :yellow)
    puts ""
    puts "     ------------------------------------------------------------------".colorize(:yellow)

    ExerciseGuide::Exercise.all.each.with_index(1) do |exercise, index|
      puts " (#{index}) Name: #{exercise.exercise_title.colorize(:cyan)} / Rating: #{exercise.exercise_rating.colorize(:cyan)} "
      puts "     ------------------------------------------------------------------".colorize(:yellow)
    end
  end

  # gets input for exercise seleted for instructions
  def get_exercise
    puts ""
    puts "---> Please type the number of the exercise for instructions:".colorize(:yellow)
    puts "---> Or type BACK to select a different muscle".colorize(:yellow)
    puts "---> Or type EXIT to exit".colorize(:red)
    puts ""

    input = gets.strip
    index = input.to_i - 1 # So we can get a number that is useful in an array

    if input == "exit" || input == "EXIT"
      end_app
    elsif input == "back" || input == "BACK"
      start_over
    elsif index <= ExerciseGuide::Exercise.all.size
      exercise = ExerciseGuide::Exercise.all[index]
      ExerciseGuide::Scraper.scrape_instructions(exercise)
    else
      puts "Oops! invalid input, please try again.".colorize(:red)
      get_exercise
    end
  end

  # puts instructions for exercise selected
  def exercise_instructions
    puts "           " + "------------------".colorize(:color => :black, :background => :yellow)
    puts "              Instructions".colorize(:yellow)
    puts "           " + "------------------".colorize(:color => :black, :background => :yellow)

    ExerciseGuide::Instructions.all.each do |exercise|
      puts ""
      puts "-------> #{exercise.title.colorize(:cyan)} <-------"
      puts ""
      puts "#{exercise.type}"
      puts "#{exercise.muscle_worked}"
      puts "#{exercise.equipment}"
      puts "#{exercise.level}"
      puts ""
      puts "#{exercise.instructions}"
      puts ""
      puts "Click on the link to watch this exercise! --->".colorize(:yellow) + " #{exercise.video_link.colorize(:blue)}"
    end
  end

  # ending message
  def end_app
    puts "See you next time!!"
    puts ""
    exit
  end

  def start_over
    ExerciseGuide::Muscle.destroy_all
    ExerciseGuide::Exercise.destroy_all
    ExerciseGuide::Instructions.destroy_all
    start
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
    puts "Type: (1) To go back to exercise results to try a different exercise".colorize(:green)
    puts "      (2) To start over".colorize(:green)
    puts "      (3) To exit".colorize(:green)
    puts ""

    case input = gets.strip
    when "1"
      exercise_results_menu
    when "2"
      start_over
    when "3"
      end_app
    else
      puts "Oops! invalid input, please try again.".colorize(:red)
      end_menu
    end
  end

end
