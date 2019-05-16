class ExerciseGuide::Scraper

    def self.scrape_body_parts
      doc = Nokogiri::HTML(open("https://www.bodybuilding.com/exercises/"))
      list = []
      doc.css("div.exercise-list li").each do |muscle|
        scraped_hash = {
          muscle_name: muscle.css("a").children.text,
          muscle_url: muscle.css("a").attribute("href").value
        }
        list << scraped_hash
      end
      list
    end

    def self.scrape_exercises
      #doc.css("dicv.ExCategory-results")
    end

end

# ExerciseGuide::Scraper.scrape_body_parts
# ExerciseGuide::Scraper.scrape_exercises
