require 'pry'
class IndecisiveDiner::CLI
    def call
        puts "Welcome, you Indecisive Diner!"
        puts "What's your name?"
        @name = gets.strip
        puts "What's your location?"
        @location = gets.strip.downcase
        if @location.split(/\s+/).length > 1
            @location = @location.split(/\s+/)
        else
            @location = [@location]
        end
        # binding.pry
        if !IndecisiveDiner::Scraper.location_check(@location)
            puts "We can't seem to find your location, please remember to enter full location name."
            @location = gets.strip.downcase
            if @location.split(/\s+/).length > 1
                @location.split(/\s+/)
            else 
                @location = [@location]
            end
        end 
        # binding.pry
        #@user = User.new(@name, @location)
        sampled_restaurant
        menu
        goodbye
    end

    def sampled_restaurant 
        @sampled_restaurant = IndecisiveDiner::Restaurant.sampled(@location)
        puts <<-DOC.gsub(/^\s+/, "")
        *
        #{@sampled_restaurant.name}
        #{@sampled_restaurant.cuisine}
        #{@sampled_restaurant.rating}/5 Stars
        *
        DOC
    end 

    def restaurant_link 
        puts "#{@sampled_restaurant.link}"
    end 

    def menu 
        puts "Wanna eat here? [yes, no, exit]"
        input = nil 
        until input == "exit"
            input = gets.strip.downcase 
            if input == "no"
                puts "Let's spin again!"
                puts "Spinning wheel"
                count = 0
                until count == 3
                    sleep 1
                    puts "."
                       count +=1
                  end
                sampled_restaurant
                puts "Wanna eat here? [yes, no, exit]"
            elsif input == "yes"
                puts "Let's make a reservation!"
                restaurant_link
                puts "[type exit]"
            end
        end 

    end 

    def goodbye 
        puts "See you next time, #{@name}!"
    end 

  end