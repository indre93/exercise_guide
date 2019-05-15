class ExerciseGuide::Scraper

    def self.scrape_body_parts
      doc = Nokogiri::HTML(open("https://bodybuilding.com/exercises"))
      binding.pry
    end

    def self.scrape_exercises

    end


end

# ExerciseGuide::Scraper.scrape_body_parts
