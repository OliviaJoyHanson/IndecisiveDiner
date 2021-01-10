require 'pry'
require 'nokogiri'
require 'open-uri'
require "net/http"
        

class IndecisiveDiner::Scraper 

    def self.location_check(location)
        if location.count == 1
            url = "https://www.opentable.com/nearby/restaurants-near-me-#{location.join}"
        else
            url = "https://www.opentable.com/nearby/restaurants-near-me-#{location.join("-")}"
        end
        
            URI.open(url).status
        rescue OpenURI::HTTPError
            false
 
    end 

    def self.scrape(location)
        if location.count == 1
            @doc = Nokogiri::HTML(URI.open("https://www.opentable.com/nearby/restaurants-near-me-#{location.join}"))
        else
            @doc = Nokogiri::HTML(URI.open("https://www.opentable.com/nearby/restaurants-near-me-#{location.join("-")}"))
        end
        # @doc = Nokogiri::HTML(URI.open("https://www.opentable.com/nearby/restaurants-near-me-fort-wayne"))
        # binding.pry
        rest_cards = @doc.css('div[data-test="restaurant-cards"]')
        # binding.pry
        @scraped_restaurants_array = []

        rest_cards.each do |card|
            
            card.children.each do |rest|
                
                name = rest.css("a h6").text.split(" ").drop(1).join(" ").strip
                cuisine_array = rest.css("._2p0jcmKJSDjEh-wNrLIpzJ").text.downcase.split(" ") - location
                
                # cuisine = cuisine_array.reject {|e| [0, cuisine_array.length - 1].include? cuisine_array.index(e)}.map{|e| e.capitalize}.join(" ")
                bubbles_indices = cuisine_array.each_index.select{|e| cuisine_array[e] == '•'} 
                # cuisine_array.length
                # if cuisine_array.index is larger than bubbles_indices[1], reject
                # binding.pry
                cuisine = cuisine_array.reject {|e| [bubbles_indices[0], bubbles_indices[1]].include?(cuisine_array.index(e)) || cuisine_array.index(e) > bubbles_indices[1]}.map{|e| e.capitalize}.join(" ")
                # if element if array matches value of index 0, delete that index and everything after that until end of array length-1
                
                
                # binding.pry
                rating = rest.css("._2s6ofZ_eiTKuvNHV3mVnaG").text
                link = rest.css("._1e9PcCDb012hY4BcGfraQB").attr("href").value
                
                @scraped_restaurants_array << IndecisiveDiner::Restaurant.new(name, cuisine, rating, link)
               
            end
        end 
        
        @scraped_restaurants_array
    end 
end 