require 'pry'
require 'nokogiri'
require 'open-uri'

class IndecisiveDiner::Scraper 

    def self.scrape(location)
        # if location.length > 1
        doc = Nokogiri::HTML(URI.open("https://www.opentable.com/nearby/restaurants-near-me-fort-wayne"))

        rest_cards = doc.css('div[data-test="restaurant-cards"]')
        # binding.pry
        @scraped_restaurants = []

        rest_cards.each do |card|
            
            # binding.pry
            # <div class="_1HpaBjJWDwElwdkD3OKS7J"><a href="https://www.opentable.com/r/red-lobster-fort-wayne?corrid=2994a1cb-4437-4fe3-a4cd-9ce19011b785&amp;avt=eyJ2IjoyLCJtIjoxLCJwIjowLCJzIjowLCJuIjowfQ&amp;p=2&amp;sd=2021-01-02T19%3A00%3A00" class="_1e9PcCDb012hY4BcGfraQB" data-test="res-card-name" aria-label="Red Lobster - Fort Wayne restaurant" target="_blank" rel="noopener noreferrer"><h6 class="k8o46Bca35RzHNtQFy3bH">1. <!-- -->Red Lobster - Fort Wayne</h6></a></div>
            card.children.each do |rest|
                
            title = rest.css("._3uVfVbI1iLfMbszbU6KoOL .k8o46Bca35RzHNtQFy3bH").text
                # name = rest.css("div._17v75S2htyk61cW3_VXibj div._1liK37RaUN7lnBs9g1TPyp div._1HpaBjJWDwElwdkD3OKS7J").text
                # binding.pry
               
            end
        end 
        
        
        # scraped = [["bakerstreet", "contemporary american", "4.8", "link1"], ["Nawa", "asian fusion", "5", "link2"]]
        
        # scraped.each do |restaurant|
            
        #     @scraped_restaurants << IndecisiveDiner::Restaurant.new(restaurant[0], restaurant[1], restaurant[2], restaurant[3])
             
            
        # end
        @scraped_restaurants 
    end 
end 