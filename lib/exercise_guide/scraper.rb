class ExerciseGuide::Scraper

    def self.scrape_body_parts
      doc = Nokogiri::HTML(open("https://www.bodybuilding.com/exercises/"))

      array_body_parts = doc.css("div.exercise-list li")
      list = []
      array_body_parts.each do |muscle|
        attributes = {
          body_part: muscle.css("a").children.text,
          muscle_url: muscle.css("a").attribute("href").value
        }
        exercise = ExerciseGuide::Exercise.new(attributes)
      end
    end

    def self.scrape_exercise_list
      # shows the list of results based on the muscle selected with equipment type

      # .css("div.ExCategory-results") <== exercise list titles
      # .css("a").attribute("href").value <== link to exercise
    end

    def self.scrape_exercise
      # shows exercise selected and includes description

      # .ccs(".ExHeading ExHeading--h3") <== title of exercise
      # .css(".bb-list--plain").text <== shows equipment type, either "body only" or "machine"
      # .css("div.grid-8 grid-12-s grid-12-m").text <== Instructions
      # .css("div.jw-media jw-reset").value || .css("video.jw-media jw-reset").value <== video example or include pics
    end

end

 ExerciseGuide::Scraper.scrape_body_parts
# ExerciseGuide::Scraper.scrape_exercises
