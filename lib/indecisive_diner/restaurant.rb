require 'pry'

class IndecisiveDiner::Restaurant
  attr_accessor :name, :cuisine, :rating, :link
    

  def initialize(name, cuisine, rating, link)
    @name = name
    @cuisine = cuisine
    @rating = rating
    @link = link
  end 

  
  def self.sampled(location)
    scraped = IndecisiveDiner::Scraper.scrape(location)
    sampled_restaurant = scraped.sample
    sampled_restaurant
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

end