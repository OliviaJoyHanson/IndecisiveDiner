require 'pry'
require 'nokogiri'
require 'open-uri'

class IndecisiveDiner::Scraper 

    def self.scrape(location)
        # if location.length > 1
        doc = Nokogiri::HTML(URI.open("https://www.opentable.com/nearby/restaurants-near-me-fort-wayne"))

        rest_box = doc.css("#mainContent div._3kGTRpUBze6qgm9OggF-31 div._2AVylkZna9eBnqoELI42uw div._2ZhFCF4LhPo6lVjuKJPqt- div[data-test]")

        binding.pry
        
        scraped = [["bakerstreet", "contemporary american", "4.8", "link1"], ["Nawa", "asian fusion", "5", "link2"]]
        @scraped_restaurants = []
        scraped.each do |restaurant|
            
            @scraped_restaurants << IndecisiveDiner::Restaurant.new(restaurant[0], restaurant[1], restaurant[2], restaurant[3])
             
            
        end
        @scraped_restaurants 
    end 
end 