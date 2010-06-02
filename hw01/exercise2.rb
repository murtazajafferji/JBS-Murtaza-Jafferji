# Murtaza Jafferji
# HW1 - Exercise 2
# 6/1/10
#
# This program displays a different random fortune each time next_fortune is called.

# contains fortunes and a method to select random fortunes
class Fortune
  
  # an array of fortunes
  FORTUNES = ["You will learn Ruby soon", "You will get an A for this course", "The Redsox will lose", 
              "You will die", "You will blink", "It will rain one day", "Tomorrow will be the day after today"]
  
  # initializes the array
  def initialize
    @seen = []
  end
  
  # selects a random, previously unseen fortune (if the number 
  # of calls is less than or equal to the number of fortunes)
  def next_fortune
    fortune = FORTUNES[(rand * FORTUNES.length).to_int] #picks a random fortune
    
    # prevents an infinite loop if the number of calls is more than the number of fortunes
    if (@seen.length >= FORTUNES.length)
      return fortune
    end
    
    # keeps randomly choosing fortunes until it finds an unseen one
    while (@seen.include?(fortune))
      fortune = FORTUNES[(rand * FORTUNES.length).to_int]
    end
    
    @seen.push(fortune) #adds the chosen fortune to the list of seen fortunes
    return fortune
  end

end

# prints different random fortunes
if __FILE__ == $0 
  f = Fortune.new
  puts f.next_fortune
  puts f.next_fortune
  puts f.next_fortune
  puts f.next_fortune
  puts f.next_fortune
  puts f.next_fortune
  puts f.next_fortune
end
    