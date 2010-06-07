=begin
Name: Hangman
Assignment: hw3
Description: This program is a hangman puzzle guesser.
Author: Murtaza Jafferji
Preconditions: Must supply a list of words (dictionary.txt).
=end

FILE = File.new("dictionary.txt")

lives = 15 
CHARS = ("a".."z").to_a #an array of characters from A to Z
common = ["e", "t", "a", "o", "i", "n", "s", "r", "h", "l", "d", "c"] #the most common letters in English words

# initialize variables
hash = Hash.new
guessed_letters = Array.new #an array of all the letters guessed so far
possible_words = Array.new #possible words, given the filled in blanks
in_play = true #to see if the game is over or not


print "Computer asks how many letters in the word: "
number = gets.chomp.to_i #convert to an integer
blank_indices = (1..number).to_a #value of indices that have not been guessed yet

# add all the words that are the same length as the user's word to an array
while (line = FILE.gets)
  if (line.length - 1 == number)
    possible_words.push line.chomp
  end
end

# make the blanks in this format: _ _ _ _ _ _
#                                 1 2 3 4 5 6
guessed_blanks = " "
empty_blanks = "_ "
numbered_blanks = "1 "
(number*2 - 2).times { guessed_blanks += " "} 
(number - 1).times {|i| empty_blanks += "_ "; numbered_blanks += "#{i+2} " }

# guess random letters until the game is either won or lost
while (in_play) 
  random_char = CHARS[rand(CHARS.size)] #get a random character from the alphabet
  
  flag = true
  while (flag)
    random_char = CHARS[rand(CHARS.size)]
    
    #guess ass common characters before other ones
    if(!common.empty?) 
      random_char = common[rand(common.size)] #get a random character from the common characters
      common.delete(random_char) #once the common character is guessed, delete it from the array
    end
    
    # guess a random character
    possible_words.each do |word|
      if (word.include?(random_char)) #the character must be contained within at least one of the possible words
        flag = false
      end
      if (guessed_letters.include?(random_char)) #the character must not have been guessed yet
        flag = true
      end
    end
  end
  
  # ask the user if his word contains the random character
  puts "Does your word contain a(n) #{random_char.upcase} (y/n)?"
  response = gets
  guessed_letters.push(random_char) #add the character to the array of guessed characters
  
  # if the character is contained within the user's word
  if response =~ /^y/
    puts "How many times does this letter appear in your word?"
    amount = gets.chomp.to_i
    
    # repeat until each duplicate of the guessed letter is filled in
    amount.times{
      puts "At what position?"
      index = gets.chomp.to_i
    
      # keep asking for a position until user enters a valid one
      while (index <= 0 or index >number)
        puts "Invalid position! Re-enter"
        index = gets.chomp.to_i 
      end
    
      index -=  1 #convert from position to index
    
      #delete all the words from the array that do not have the guessed character at the specified index
      possible_words.delete_if {|word| word[index] != random_char} 
    
      # remove the index from the array of blank indices because it is filled    
      blank_indices.delete (index + 1)
      guessed_blanks[index*2] = random_char #replace the blank space with the guessed character
    }
    
  # if the character is not contained within the user's word
  else
    lives -= 1
    possible_words.delete_if {|word| word.include? random_char} #delete words that have the incorrect character
  end 
  
  # list the possible words that it could be
  puts "Possible words:"
  puts possible_words
  
  # print the results
  puts "User has #{lives} lives!"
  puts guessed_blanks
  puts empty_blanks
  puts numbered_blanks

  # delete all the spaces to get a compact word
  my_guess = guessed_blanks.delete(" ")
  
  # if there are no words left in the dictionary that meet the criteria
  if possible_words.empty?
    puts "You messed up or your word is not in the dictionary."
    in_play = false
  
  # if all the spaces are filled in
  elsif (blank_indices.empty?)
    puts "I win. Your word is #{my_guess}."
    in_play = false
  
  # if there is only word left, that has to be correct
  elsif (possible_words.size == 1)
    puts "I win. Your word is #{possible_words[0]}."
    in_play = false
  
  # if all lives are lost
  elsif (lives == 0)
    # make a random guess from the remaining words
    puts "I lose. By chance, is your word #{possible_words[rand(possible_words.size)]}"
    in_play = false
  end
end
