class ExerciseGuide::Scraper

    def self.scrape_body_parts
      doc = Nokogiri::HTML(open("https://www.bodybuilding.com/exercises/"))
      list = []

      doc.css("div.exercise-list li").css("a").each do |muscle|
        list << muscle.children.text
      end
      list
    end


    def self.scrape_exercises
      #scrape_exercises
    end

end

# ExerciseGuide::Scraper.scrape_body_parts
# ExerciseGuide::Scraper.scrape_exercises
