require 'colorize'

class ExerciseGuide::CLI

  def start
    puts ""
    puts "     " + "-------------------------------------------".colorize(:color => :black, :background => :yellow)
    puts "         Welcome to the Exercise Guide App!".upcase.colorize(:yellow)
    puts "     " + "-------------------------------------------".colorize(:color => :black, :background => :yellow)
    puts ""
    puts " Learn different exercises based on the selected muscle!".colorize(:yellow)
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
      puts ""
      puts " (#{index}) ".colorize(:yellow) + "#{muscle.name.colorize(:cyan)}"
    end
  end

  # gets input for muscle selected
  def get_muscle
    puts ""
    puts "---> Please type the number of the muscle that you would like to exercise:".colorize(:yellow)
    puts "---> Or type ".colorize(:red) + "EXIT".colorize(:red).underline
    puts ""
    input = gets.strip
    index = input.to_i

    if input == "exit" || input == "EXIT"
      end_app
    elsif index <= ExerciseGuide::Muscle.all.size && index > 0
      muscle = ExerciseGuide::Muscle.all[index - 1]
      ExerciseGuide::Scraper.scrape_exercises(muscle)
      puts "You have selected #{muscle.name.colorize(:cyan).underline}..."
    else
      puts "Oops! invalid input, please try again.".colorize(:red)
      get_muscle
    end
  end

  # list exercises that corresponds to muscle selected
  def list_exercises
    puts ""
    puts "          " + "--------------------".colorize(:color => :black, :background => :yellow)
    puts "            Exercise results".upcase.colorize(:yellow)
    puts "          " + "--------------------".colorize(:color => :black, :background => :yellow)
    puts ""
    puts "     ---------------------------------------------------------------------------------".colorize(:yellow)

    ExerciseGuide::Exercise.all.each.with_index(1) do |exercise, index|
      puts " (#{index}) ".colorize(:yellow) + "#{exercise.exercise_title.colorize(:cyan)} / Rating: #{exercise.exercise_rating.colorize(:cyan)} "
      puts "     ---------------------------------------------------------------------------------".colorize(:yellow)
    end
  end

  # gets input for exercise seleted for instructions
  def get_exercise
    puts ""
    puts "---> Please type the number of the exercise for instructions:".colorize(:yellow)
    puts "---> Or type ".colorize(:yellow) + "BACK".colorize(:yellow).underline + " to select a different muscle".colorize(:yellow)
    puts "---> Or type ".colorize(:red) + "EXIT".colorize(:red).underline
    puts ""
    input = gets.strip
    index = input.to_i

    if input == "exit" || input == "EXIT"
      end_app
    elsif input == "back" || input == "BACK"
      puts ""
      start_over
      puts ""
    elsif index <= ExerciseGuide::Exercise.all.size && index > 0
      exercise = ExerciseGuide::Exercise.all[index - 1]
      ExerciseGuide::Scraper.scrape_instructions(exercise)
    else
      puts "Oops! invalid input, please try again.".colorize(:red)
      get_exercise
    end
  end

  # puts instructions for exercise selected
  def exercise_instructions
    puts ""
    puts "           " + "------------------".colorize(:color => :black, :background => :yellow)
    puts "              Instructions".upcase.colorize(:yellow)
    puts "           " + "------------------".colorize(:color => :black, :background => :yellow)

    ExerciseGuide::Instructions.all.each do |exercise|
      puts ""
      puts "---------> #{exercise.title.colorize(:cyan)} <---------"
      puts ""
      puts " Type: #{exercise.type.colorize(:cyan)}"
      puts " Main muscle worked: #{exercise.muscle_worked.colorize(:cyan)}"
      puts " Equipment type: #{exercise.equipment.colorize(:cyan)}"
      puts ""
      exercise.instructions.each.with_index(1) {|step, index| puts " #{index}.#{step.colorize(:cyan)}"}
      puts ""
      puts " Click on the link to watch this exercise! --->".colorize(:yellow) + " #{exercise.video_link.colorize(:blue)}"
    end
  end

  def end_menu
    puts ""
    puts ""
    puts " Type: (1) To go back to exercise results to try a different exercise".colorize(:yellow)
    puts "       (2) To start over".colorize(:yellow)
    puts "       (3) To exit".colorize(:yellow)
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

  def exercise_results_menu
    ExerciseGuide::Instructions.destroy_all
    list_exercises
    get_exercise
    exercise_instructions
    end_menu
  end

  def start_over
    ExerciseGuide::Muscle.destroy_all
    ExerciseGuide::Exercise.destroy_all
    ExerciseGuide::Instructions.destroy_all
    start
  end

  # ending message
  def end_app
    puts " Goodbye!".colorize(:yellow)
    puts ""
    exit
  end

end
