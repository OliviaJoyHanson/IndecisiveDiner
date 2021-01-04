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
    # see if you can use tap method here
  end

end