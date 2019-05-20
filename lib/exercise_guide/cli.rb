class ExerciseGuide::CLI

  def start
    puts "Welcome to the Exercise Guide App!"
    puts "Please type the muscle that you would like to exercise"
    puts "            -----------------"
    puts ExerciseGuide::Scraper.scrape_body_parts
    #Make sure to only list muscle names - not muscle url
    puts "            -----------------"
    #gets input

    #puts "Type the exercise for more details"
    #puts description and link for video
  end

  def list_body_parts
    #list body parts that would like to exercise
  end

  def list_exercises
    #lists all exercises for that body part
  end


end
