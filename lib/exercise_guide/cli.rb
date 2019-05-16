class ExerciseGuide::CLI

  def start
    puts "Welcome to the Exercise Guide App!"
    puts "Please type the muscle that you would like to exercise"
    puts "            -----------------"
    puts ExerciseGuide::Scraper.scrape_body_parts
    #Make sure to only list muscle names - not muscle url
    puts "            -----------------"

    #list body parts
    #gets input
    #lists all exercises for that body part
    #puts "Type the exercise for more details"
    #puts description and link for video
  end
end
