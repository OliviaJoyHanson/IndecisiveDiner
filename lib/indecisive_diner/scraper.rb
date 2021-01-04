require 'pry'
require 'nokogiri'
require 'open-uri'

class IndecisiveDiner::Scraper 

    def self.scrape_url_check(location)
        @doc = Nokogiri::HTML(URI.open("https://www.opentable.com/nearby/restaurants-near-me-fort-wayne"))
    end 

    def self.scrape(location)
        # if location.length > 1
        @doc = Nokogiri::HTML(URI.open("https://www.opentable.com/nearby/restaurants-near-me-fort-wayne"))
        # binding.pry
        rest_cards = @doc.css('div[data-test="restaurant-cards"]')
        # binding.pry
        @scraped_restaurants_array = []

        rest_cards.each do |card|
            
            card.children.each do |rest|
                
                name = rest.css("a h6").text.split(" ").drop(1).join(" ").strip
                cuisine = rest.css("._2p0jcmKJSDjEh-wNrLIpzJ").text.split(" ")[1]
                rating = rest.css("._2s6ofZ_eiTKuvNHV3mVnaG").text
                link = rest.css("._1e9PcCDb012hY4BcGfraQB").attr("href").value
                
                @scraped_restaurants_array << IndecisiveDiner::Restaurant.new(name, cuisine, rating, link)
               
            end
        end 
        
        @scraped_restaurants_array
    end 
end 