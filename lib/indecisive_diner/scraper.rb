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

    def self.page_count_exists?(location, counter)

        # if count is more than the scraped text (which is the page number) of the last index number of the <ul class="_1RRLlO4Nj5VOBsZAzSKl8T"><li class="_3Y_18dirxSlbwfPU0nr-t_" data-test="pagination-link"><span class="_2ZZBeg5QBYidoAx28zsMwU G1kfyull_V3y-AuTlAlGm _3Hm0yYcMbrNaW1gTFrK51C">1</span></li><li class="_3Y_18dirxSlbwfPU0nr-t_" data-test="pagination-link"><a href="/" class="_3GP4hokChzyxZ_vA2sI6yU _1nRxjJjjm2uSL4IWEyfidy _2ZZBeg5QBYidoAx28zsMwU G1kfyull_V3y-AuTlAlGm" aria-label="Go to page number 2">2</a></li><li class="_3Y_18dirxSlbwfPU0nr-t_" data-test="pagination-link"><a href="/" class="_3GP4hokChzyxZ_vA2sI6yU _1nRxjJjjm2uSL4IWEyfidy _2ZZBeg5QBYidoAx28zsMwU G1kfyull_V3y-AuTlAlGm" aria-label="Go to page number 3">3</a></li></ul> node, then return false


        if location.count == 1
            doc = Nokogiri::HTML(URI.open("https://www.opentable.com/nearby/restaurants-near-me-#{location.join}?prices=&cuisines=&corrid=77d80551-2985-4954-bb68-416c677f9ced&page=1"))
        else
            doc = Nokogiri::HTML(URI.open("https://www.opentable.com/nearby/restaurants-near-me-#{location.join("-")}?prices=&cuisines=&corrid=77d80551-2985-4954-bb68-416c677f9ced&page=1"))
        end

        # binding.pry
        counter <= doc.css('div._3kGTRpUBze6qgm9OggF-31 ul._1RRLlO4Nj5VOBsZAzSKl8T li._3Y_18dirxSlbwfPU0nr-t_').map{|li| li.text}.pop.to_i
        # <li class="_3Y_18dirxSlbwfPU0nr-t_" data-test="pagination-link"><span class="_2ZZBeg5QBYidoAx28zsMwU G1kfyull_V3y-AuTlAlGm _3Hm0yYcMbrNaW1gTFrK51C">1</span></li>
        #     URI.open(url).status
        # rescue OpenURI::HTTPError
        #     false
    end 

    def self.scrape(location)
        @doc_array = []
        
        # counter = 1
        # binding.pry
        # until !self.page_count_check(location, count) insert count number into end of url to scrape different page of restaurants, and add that scraped page to doc_array. then iterate through doc array to add to scraped_restaurants.
        # until !page_count_exists?(location, counter)
        # counter = 1
        # until !page_count_exists?(location, counter)

            if location.count == 1
                # doc = Nokogiri::HTML(URI.open("https://www.opentable.com/nearby/restaurants-near-me-#{location.join}"))
                # @doc_array << doc
                counter = 1
                until page_count_exists?(location, counter) == false
                    @doc_array << Nokogiri::HTML(URI.open("https://www.opentable.com/nearby/restaurants-near-me-#{location.join}?prices=&cuisines=&corrid=77d80551-2985-4954-bb68-416c677f9ced&page=#{counter}"))
                    counter += 1
                end
            else
                # doc = Nokogiri::HTML(URI.open("https://www.opentable.com/nearby/restaurants-near-me-#{location.join("-")}"))
                # @doc_array << doc
                counter = 1
                until page_count_exists?(location, counter) == false
                    @doc_array << Nokogiri::HTML(URI.open("https://www.opentable.com/nearby/restaurants-near-me-#{location.join("-")}?prices=&cuisines=&corrid=77d80551-2985-4954-bb68-416c677f9ced&page=#{counter}"))
                    counter += 1
                    # binding.pry
                end
                # binding.pry
            end
            # @doc = Nokogiri::HTML(URI.open("https://www.opentable.com/nearby/restaurants-near-me-fort-wayne"))
            # binding.pry
        # end

        # binding.pry

        @scraped_restaurants_array = []

        @doc_array.each do |doc|

            rest_cards = doc.css('div[data-test="restaurant-cards"]')
            # binding.pry

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
        end
        @scraped_restaurants_array
        # binding.pry
    end 
end 