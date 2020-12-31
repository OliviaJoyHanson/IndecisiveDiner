require 'pry'

class IndecisiveDiner::Scraper 

    def self.scrape(location)
        scraped = [["bakerstreet", "contemporary american", "4.8", "link1"], ["Nawa", "asian fusion", "5", "link2"]]
        @scraped_restaurants = []
        scraped.each do |restaurant|
            
            @scraped_restaurants << IndecisiveDiner::Restaurant.new(restaurant[0], restaurant[1], restaurant[2], restaurant[3])
             
            
        end
        @scraped_restaurants 
    end 
end 