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

    def self.page_count_check(location, count)
        if location.count == 1
            url = "https://www.opentable.com/nearby/restaurants-near-me-#{location.join}?prices=&cuisines=&corrid=77d80551-2985-4954-bb68-416c677f9ced&page=#{count}"
        else
            url = "https://www.opentable.com/nearby/restaurants-near-me-#{location.join("-")}?prices=&cuisines=&corrid=77d80551-2985-4954-bb68-416c677f9ced&page=#{count}"
        end
        
            URI.open(url).status
        rescue OpenURI::HTTPError
            false
    end 

    def self.scrape(location)
        count = 1
        # until !self.page_count_check(location, count)

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
                bubbles_indices = cuisine_array.each_index.select{|e| cuisine_array[e] == '•'} 
                cuisine = cuisine_array.reject {|e| [bubbles_indices[0], bubbles_indices[1]].include?(cuisine_array.index(e)) || cuisine_array.index(e) > bubbles_indices[1]}.map{|e| e.capitalize}.join(" ")
                
                rating = rest.css("._2s6ofZ_eiTKuvNHV3mVnaG").text

                link = rest.css("._1e9PcCDb012hY4BcGfraQB").attr("href").value
                
                @scraped_restaurants_array << IndecisiveDiner::Restaurant.new(name, cuisine, rating, link)
               
            end
        end 
        
        @scraped_restaurants_array
    end 
end 