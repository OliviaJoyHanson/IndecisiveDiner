require 'pry'
class IndecisiveDiner::CLI
    def call
        puts "Welcome, you Indecisive Diner!"
        puts "What's your name?"
        @name = gets.strip.downcase
        puts "What's your location?"
        @location = gets.strip.downcase
        #@user = User.new(@name, @location)
        sampled_restaurant
        menu
        goodbye
    end

    def sampled_restaurant 
        @sampled_restaurant = IndecisiveDiner::Restaurant.sampled(@location)
        puts <<-DOC 
        #{@sampled_restaurant.name}
        #{@sampled_restaurant.cuisine}
        #{@sampled_restaurant.rating}
        #{@sampled_restaurant.link}
        DOC
    end 

    def restaurant_link 
        @sampled_restaurant.link
    end 

    def menu 
        puts "Wanna eat here? [yes, no, exit]"
        input = nil 
        while input != "exit"
            input = gets.strip.downcase
            if input == "yes"
                puts "Let's make a reservation!"
                puts restaurant_link
            elsif input == "no"
                puts "Let's spin again!"
                puts "Spinning wheel..."
                sampled_restaurant
                puts "Wanna eat here? [yes, no, exit]"
            else
                puts "Didn't quite get that... type yes, no, or exit"
            end 
        end
    end 

    def goodbye 
        "See you next time, #{@name}!"
    end 

    # def call
    #   list_deals
    #   menu
    #   goodbye
    # end
  
    # def list_deals
    #   # here doc - http://blog.jayfields.com/2006/12/ruby-multiline-strings-here-doc-or.html
    #   puts "Today's Daily Deals:"
    #   @deals = DailyDeal::Deal.today
    #   @deals.each.with_index(1) do |deal, i|
    #     puts "#{i}. #{deal.name} - #{deal.price} - #{deal.availability}"
    #   end
    # end
  
    # def menu
    #   input = nil
    #   while input != "exit"
    #     puts "Enter the number of the deal you'd like more info on or type list to see the deals again or type exit:"
    #     input = gets.strip.downcase
  
    #     if input.to_i > 0
    #       the_deal = @deals[input.to_i-1]
    #       puts "#{the_deal.name} - #{the_deal.price} - #{the_deal.availability}"
    #     elsif input == "list"
    #       list_deals
    #     else
    #       puts "Not sure what you want, type list or exit."
    #     end
    #   end
    # end
  
    # def goodbye
    #   puts "See you tomorrow for more deals!!!"
    # end
  end