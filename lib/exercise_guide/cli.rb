class ExerciseGuide::CLI
  attr_accessor :sorted_body_parts

  def start
    puts ""
    puts "     ----------------------------------".colorize(:yellow)
    puts "     Welcome to the Exercise Guide App!".colorize(:yellow)
    puts "     ----------------------------------".colorize(:yellow)
    puts ""
    ExerciseGuide::Scraper.scrape_body_parts
    list_body_parts
    get_body_part_method
    #gets input and lists exercises based on input
    puts ""
    puts "           ------------------".colorize(:yellow)
    puts "            Exercise results".colorize(:yellow)
    puts "           ------------------".colorize(:yellow)
    ExerciseGuide::Scraper.scrape_exercises
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

  def sort_body_parts
    @sorted_body_parts = ExerciseGuide::BodyPart.all.sort_by {|muscle| muscle.name}
  end

  def list_body_parts
    puts "==> Please type the number of the body part that you would like to exercise:"
    puts ""
    ExerciseGuide::BodyPart.all.each.with_index(1) do |body_part, index, rating|
      puts "#{index}. #{body_part.name}"
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

  def exercise_instructions
    ExerciseGuide::Instructions.all.each do |exercise|
      puts "    #{exercise.title}"
      puts ""
      puts "#{exercise.instructions}"
      puts ""
      puts "Click on the link to watch this exercise! ===> #{exercise.video.colorize(:blue)}"
    end
  end

  def get_body_part_method
    input = gets.strip
    index = input.to_i - 1 # So we can get a number that is useful in an array
    if index.between?(0,17)
      muscle = ExerciseGuide::BodyPart.all[index]
      puts "#{muscle.name}"
      list_exercises
        #continue w program
        #find that body part
        #scrape - DONE
        #list exercise that corresponds
    elsif input == "exit"
      #allow this method to end
    else
      puts "Oops! invalid input, please try again."
      get_body_part_method
    end
  end

  def get_exercise_method

  end

end
