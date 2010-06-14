# Murtaza Jafferji
# HW1 - Exercise 2 RESUBMIT
# 6/14/10
#
# This program displays a different random fortune each time next_fortune is called.

# contains fortunes and a method to select random fortunes
class Fortune
  # The marshal file containing a dump of @seen
  SEEN_FORTUNES = "seen_fortunes.marshal"
  
  # initializes the array
  def initialize
    @seen = []
  
    # load the marshal dump if it exists
    if File.size?(SEEN_FORTUNES)
      @seen_fortunes = Marshal.load(File.new(SEEN_FORTUNES, 'r'))
    end
  
    # an array of fortunes
    @fortunes = ["You will learn Ruby soon", "You will get an A for this course", "The Redsox will lose", 
                 "You will die", "You will blink", "It will rain one day", "Tomorrow will be the day after today"]
  end
  
  # return a random, unseen fortune
  def get_unseen_fortune
    # if all fortunes have been seen, empty @seen
    if @seen.size == @fortunes.size
      @seen = []
    end
    unseen_fortunes = @fortunes - @seen_fortunes
    unseen_fortunes.sample
  end
  
  # return a random fortune and add to Marshal
  def next_fortune
    fortune = get_unseen_fortune
    @seen << fortune
    Marshal.dump(@seen, File.new(SEEN_FORTUNES, 'w'))
    fortune
  end

end

# prints different random fortunes
if __FILE__ == $0 
  f = Fortune.new
  puts f.next_fortune
  puts f.next_fortune
end
    