require 'pry'

class IndecisiveDiner::Restaurant
  attr_accessor :name, :cuisine, :rating, :link
    

  def initialize(name, cuisine, rating, link)
    @name = name
    @cuisine = cuisine
    @rating = rating
    @link = link
  end 


    

    
  
    def self.sampled
      sampled_restaurant = @scraped_restaurants.sample
      puts <<-DOC 
        #{sampled_restaurant.name}
        #{sampled_restaurant.cuisine}
        #{sampled_restaurant.rating}
        #{sampled_restaurant.link}
      DOC
      # @name = "BakerStreet"
      # @cuisine = "Contemporary American"
      # @rating = "4.8/5 stars"
      # @link = "https://www.opentable.com/bakerstreet?corrid=43cdb721-2ee5-4458-a691-0e0e57d0483b&avt=eyJ2IjoyLCJtIjoxLCJwIjowLCJzIjowLCJuIjowfQ&p=2&sd=2020-12-20T19%3A00%3A00"

      # puts <<-DOC
      #   #{@name}
      #   Cuisine: #{@cuisine}
      #   Rating: #{@rating}
      # DOC
    end


    # attr_accessor :name, :price, :availability, :url
  
    # def self.today
    #   # Scrape woot and meh and then return deals based on that data
    #   self.scrape_deals
    # end
  
    # def self.scrape_deals
    #   deals = []
  
    #   deals << self.scrape_woot
    #   deals << self.scrape_meh
  
    #   deals
    # end
  
    # def self.scrape_woot
    #   doc = Nokogiri::HTML(open("https://woot.com"))
  
    #   deal = self.new
    #   deal.name = doc.search("h2.main-title").text.strip
    #   deal.price = doc.search("#todays-deal span.price").text.strip
    #   deal.url = doc.search("a.wantone").first.attr("href").strip
    #   deal.availability = true
  
    #   deal
    # end
  
    # def self.scrape_meh
    #   doc = Nokogiri::HTML(open("https://meh.com"))
  
    #   deal = self.new
    #   deal.name = doc.search("section.features h2").text.strip
    #   deal.price = doc.search("button.buy-button").text.gsub("Buy it.", "").strip
    #   deal.url = "https://meh.com"
    #   deal.availability = true
  
    #   deal
    # end
  end