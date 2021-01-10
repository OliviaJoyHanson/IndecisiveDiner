require 'pry'
require 'nokogiri'
require 'open-uri'
require "net/http"
        

class IndecisiveDiner::Scraper 

    def self.location_check(location)
        url = "https://www.opentable.com/nearby/restaurants-near-me-#{location.join}"

        
            URI.open(url).status
        rescue OpenURI::HTTPError
            false
 

        # binding.pry
        # Net::HTTP.get_response(url).is_a?(Net::HTTPSuccess)

        # response = HTTParty.get('http://google.com', follow_redirects: true)

        # response = nil
        # seen = Set.new
        # loop do
        #     url = URI.parse(url)
        #     break if seen.include? url.to_s
        #     break if seen.size > max_redirects
        #     seen.add(url.to_s)
        #     response = Net::HTTP.new(url.host, url.port).request_head(url.path)
        #     if response.kind_of?(Net::HTTPRedirection)
        #     url = response['location']
        #     else
        #     break
        #     end
        # end
        # response.kind_of?(Net::HTTPSuccess) && url.to_s

        # url = URI.parse(url_string)
        # req = Net::HTTP.new(url.host, url.port)
        # req.use_ssl = (url.scheme == 'https')
        # path = url.path if url.path.present?
        # res = req.request_head(path || '/')
        # res.code != "404" # false if returns 404 - not found
        # rescue Errno::ENOENT
        # false # false if can't find the server

        # uri = URI.parse(url)
        # uri.is_a?(URI::HTTP) && !uri.host.nil?
        # binding.pry
        # rescue URI::InvalidURIError
        # false

        # uri = URI.parse(url)
        # Net::HTTP.start(uri.host, uri.port) do |http|
        #     binding.pry
        #     return http.head(uri.request_uri).code == "200"
        # end
        
        # req = Net::HTTP.new(url.host, url.port)
        # req.use_ssl = true if url.scheme == 'https'
        # res = req.request_head(url.path)
 
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