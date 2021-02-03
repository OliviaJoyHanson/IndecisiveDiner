require 'pry'

class IndecisiveDiner::Restaurant
  attr_accessor :name, :cuisine, :rating, :link

  def initialize(name, cuisine, rating, link)
    @name = name
    @cuisine = cuisine
    @rating = rating
    @link = link
  end 
  
  def self.scraped(location)
    IndecisiveDiner::Scraper.scrape(location)
  end

end