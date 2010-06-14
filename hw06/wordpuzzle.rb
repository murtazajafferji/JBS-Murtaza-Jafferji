=begin
Name: Word Puzzle
Assignment: hw06
Description: This program is takes two words and returns a chain of words between the words.
Author: Murtaza Jafferji
Preconditions: Must supply a dictionary file (dictionary.txt).
=end

class WordPuzzle
  
  def initialize (word1, word2)
    @word1 = word1
    @word2 = word2
  end
  
  # tests if words are acceptable and then displays a chain between them
  def play
    if (test)
      # next four lines just to see if there was no chain between the words
      test_list = build_chain
      test_list.delete(@word1)
      test_list.delete(@word2)
      if (distance(@word1, @word2) > 1 and test_list.empty?)
        puts "Error: No chain between words"
      else
        puts build_chain
      end
    end
  end
  
  # reads the dictionary file and returns an array of all words of the same length as the words
  def make_list
    file = File.new("dictionary.txt")
    dict_list = Array.new
    # add all the words that are the same length as the user's word to an array
    while (line = file.gets)
      if (line.length - 1 == @word1.length)
        dict_list.push line.chomp
      end
    end
    dict_list
  end

  # tests to see if the words are in the dictionary and of the same length
  def test
    dict_list = make_list
    #make sure they're the same length
    if @word1.length != @word2.length
      puts "Error: Words of different lengths"
      false
    #make sure it is in the dictionary file
    elsif (!dict_list.include?(@word1)||!dict_list.include?(@word2))
      puts "Error: Word does not exist"
      false
    else
      true
    end
  end
    
  # finds how many characters differ in each position
  def distance (w1, w2)
    count = 0
    #add a count for every index where the characters are different
    i = 0
    while i < w2.length
      if w1[i].downcase != w2[i].downcase
        count = count + 1
      end
      i = i + 1
    end
    count
  end
        
  # builds a chain between the words
  def build_chain
    i = distance(@word1, @word2) 
    k = 0
    list = Array.new
    dict_list = make_list
    while i > 0
      j = 0 
      while j < dict_list.length
        #get a increasing edit distance from @word1 and a decreasing edit distance from wor2
        if (distance(@word1, dict_list[j]) <= k && distance(@word2, dict_list[j]) <= i)
          list.push dict_list[j]
        end
        j = j + 1
      end
      k = k + 1
      i = i - 1
    end
    list.push(@word2)
  end
end
start = Time.now

response = "y"
while (response =~ /^y/)
  start = Time.now
  print "Enter two words: "
  words = gets
  word1 = words.split[0]
  word2 = words.split[1]
  
  puts "Building chain..."
  game = WordPuzzle.new(word1, word2)
  game.play

  puts "TIME: #{Time.now - start} seconds"
  
  print "Do you want to play again (y/n)? "
  response = gets
  puts
  
end