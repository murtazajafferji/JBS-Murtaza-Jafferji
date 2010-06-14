=begin
Name: LCD Display
Assignment: hw06
Description: This program takes numbers from a user and displays an LCD style version.
Author: Murtaza Jafferji
=end

# arrays of strings that make an LCD visualization of each number
ZERO = [" -- ", "|  |", "|  |", "    ", "|  |", "|  |", " -- "]
ONE = ["    ", "   |", "   |", "    ", "   |", "   |", "    "]
TWO = [" -- ", "   |", "   |", " -- ", "|   ", "|   ", " -- "]
THREE = [" -- ", "   |", "   |", "  --", "   |", "   |", " -- "]
FOUR = ["    ", "|  |", "|  |", "  --", "   |", "   |", "    "]
FIVE = [" -- ", "|   ", "|   ", " -- ", "   |", "   |", " -- "]
SIX = [" -- ", "|   ", "|   ", " -- ", "|  |", "|  |", " -- "]
SEVEN = [" -- ", "   |", "   |", "   |", "   |", "   |", "    "]
EIGHT = [ " -- ", "|  |", "|  |", " -- ", "|  |", "|  |", " -- "]
NINE = [" -- ", "|  |", "|  |", " -- ", "   |", "   |", " -- "]

# a hash from each number to its LCD visualization array
hash = {0 => ZERO, 1 => ONE, 2 => TWO, 3 => THREE, 4 => FOUR, 5 => FIVE, 6 => SIX, 7 => SEVEN, 8 => EIGHT, 9 => NINE}

puts "Enter a number:"
input = gets.chomp

# prints each line of all the numbers given
for line in (0..6)
  string = ""
  for number in (0..input.length - 1) 
    string += hash[input[number].to_i][line] + " "
  end
  puts string
end
