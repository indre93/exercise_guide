require 'colorize'

class ExerciseGuide::CLI

  def start
    start_title
    list_muscles
    get_muscle
    list_exercises
    get_exercise
    exercise_instructions
    end_menu
  end

  def start_title
    puts ""
    puts "                     " + "-------------------------------------------".colorize(:color => :black, :background => :yellow)
    puts "                         Welcome to the Exercise Guide App!".upcase.colorize(:yellow)
    puts "                     " + "-------------------------------------------".colorize(:color => :black, :background => :yellow)
    puts ""
    puts "______________===========================================================______________".colorize(:red)
    puts "                Learn different exercises based on the selected muscle!".colorize(:yellow)
    puts "______________===========================================================______________".colorize(:red)
  end

  def list_muscles
    ExerciseGuide::Scraper.scrape_muscles
    ExerciseGuide::Muscle.all.each.with_index(1) do |muscle, index|
      puts ""
      puts " (#{index}) ".colorize(:yellow) + "#{muscle.name.colorize(:cyan)}"
    end
  end

  def get_muscle
    puts ""
    puts ""
    puts "     =====================================================================".colorize(:red)
    puts "---> Please type the number of the muscle that you would like to exercise:".colorize(:yellow)
    puts "---> Or type EXIT".colorize(:yellow)
    puts "     =====================================================================".colorize(:red)
    puts ""
    input = gets.strip
    index = input.to_i

    if input == "exit" || input == "EXIT"
      exit_message
    elsif index <= ExerciseGuide::Muscle.all.size && index > 0
      muscle = ExerciseGuide::Muscle.all[index - 1]
      ExerciseGuide::Scraper.scrape_exercises(muscle)
      puts "You have selected: " + "(#{index}) #{muscle.name}...".colorize(:blue)
    else
      puts " Oops! invalid input, please try again.".colorize(:red)
      get_muscle
    end
  end

  def list_exercises
    exercise_results_title
    ExerciseGuide::Exercise.all.each.with_index(1) do |exercise, index|
      puts " (#{index}) ".colorize(:yellow) + "#{exercise.exercise_title.colorize(:cyan)} / Rating: #{exercise.exercise_rating.colorize(:cyan)} "
      puts "     ----------------------------------------------------------------------------".colorize(:yellow)
    end
  end

  def get_exercise
    puts ""
    puts ""
    puts "     ========================================================".colorize(:red)
    puts "---> Please type the number of the exercise for instructions:".colorize(:yellow)
    puts "---> Or type BACK to select a different muscle".colorize(:yellow)
    puts "---> Or type EXIT".colorize(:yellow)
    puts "     ========================================================".colorize(:red)
    puts ""
    input = gets.strip
    index = input.to_i

    if input == "exit" || input == "EXIT"
      exit_message
    elsif input == "back" || input == "BACK"
      puts ""
      start_over
      puts ""
    elsif index <= ExerciseGuide::Exercise.all.size && index > 0
      exercise = ExerciseGuide::Exercise.all[index - 1]
      ExerciseGuide::Scraper.scrape_instructions(exercise)
      puts "You have selected: " + "(#{index}) #{exercise.exercise_title}...".colorize(:blue)
    else
      puts " Oops! invalid input, please try again.".colorize(:red)
      get_exercise
    end
  end

  def exercise_instructions
    instructions_title
    ExerciseGuide::Instructions.all.each do |exercise|
      puts ""
      puts " Exercise Name: #{exercise.title.colorize(:cyan)}"
      puts " Main Muscle Worked: #{exercise.muscle_worked.colorize(:cyan)}"
      puts " Type: #{exercise.type.colorize(:cyan)}"
      puts " Equipment Type: #{exercise.equipment.colorize(:cyan)}"
      puts ""
      exercise.instructions.each.with_index(1) {|steps, index| puts " #{index}. #{steps.colorize(:cyan)}"}
      puts ""
      puts " Click on the link to watch this exercise! --->".colorize(:yellow) + " #{exercise.video_link.colorize(:blue)}"
    end
  end

  def end_menu
    puts ""
    puts ""
    puts "_________________________________=============================================_________________________________".colorize(:red)
    puts "                                    Type: (1) To try a different exercise".colorize(:yellow)
    puts "                                          (2) To start over".colorize(:yellow)
    puts "                                          (3) To exit".colorize(:yellow)
    puts "_________________________________=============================================_________________________________".colorize(:red)
    puts ""

    case input = gets.strip
    when "1"
      exercise_results_menu
    when "2"
      start_over
    when "3"
      exit_message
    else
      puts " Oops! invalid input, please try again.".colorize(:red)
      end_menu
    end
  end

  def exercise_results_title
    puts ""
    puts "                    " + "--------------------".colorize(:color => :black, :background => :yellow)
    puts "                      Exercise results".upcase.colorize(:yellow)
    puts "                    " + "--------------------".colorize(:color => :black, :background => :yellow)
    puts ""
    puts "     ----------------------------------------------------------------------------".colorize(:yellow)
  end

  def instructions_title
    puts ""
    puts "                     " + "------------------".colorize(:color => :black, :background => :yellow)
    puts "                        Instructions".upcase.colorize(:yellow)
    puts "                     " + "------------------".colorize(:color => :black, :background => :yellow)
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

  def exit_message
    puts "Goodbye!! ".colorize(:yellow)
    puts ""
    exit
  end

end
