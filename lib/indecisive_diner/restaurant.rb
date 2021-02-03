require 'pry'

class IndecisiveDiner::Restaurant
  attr_accessor :name, :cuisine, :rating, :link

  @all = []
    

  def initialize(name, cuisine, rating, link)
    @name = name
    @cuisine = cuisine
    @rating = rating
    @link = link
  end 

  def self.scraped

  end 

  
  def self.scraped(location)
    IndecisiveDiner::Scraper.scrape(location)
    # see if you can use tap method here
  end

end