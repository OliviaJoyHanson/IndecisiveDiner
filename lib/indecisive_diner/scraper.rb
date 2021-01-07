require 'pry'
require 'nokogiri'
require 'open-uri'

class IndecisiveDiner::Scraper 

    def self.all_locations
        location_tab = Nokogiri::HTML(URI.open(""))
    end 

    def self.location_check(location)
        # uri = URI.parse "https://www.opentable.com/nearby/restaurants-near-me-#{location.join}" rescue nil
        url = URI.parse("https://www.opentable.com/nearby/restaurants-near-me-#{location.join}")
        Net::HTTP.start(url.host, url.port) do |http|
            http.head(url.request_uri).code == '200'
        end
        rescue
            false
        # binding.pry
        # if location.length <2
        #     @doc = Nokogiri::HTML(URI.open("https://www.opentable.com/nearby/restaurants-near-me-#{location.join}"))
        # else
        #     @doc = Nokogiri::HTML(URI.open("https://www.opentable.com/nearby/restaurants-near-me-fort-wayne"))
        #     # DEPENDING ON LENGTH OF LOCATION ARRAY (AMOUNT OF WORDS IN LOCATION) WILL NEED TO INSERT DASH (-) BETWEEN EACH WORD IN URL
        # end 
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
                cuisine_array = rest.css("._2p0jcmKJSDjEh-wNrLIpzJ").text.downcase.split(" ") - location
                cuisine = cuisine_array.reject {|e| [0, cuisine_array.length - 1].include? cuisine_array.index(e)}.map{|e| e.capitalize}.join(" ")
                # binding.pry
                rating = rest.css("._2s6ofZ_eiTKuvNHV3mVnaG").text
                link = rest.css("._1e9PcCDb012hY4BcGfraQB").attr("href").value
                
                @scraped_restaurants_array << IndecisiveDiner::Restaurant.new(name, cuisine, rating, link)
               
            end
        end 
        
        @scraped_restaurants_array
    end 
end 