=begin
Name: dictionary.rb (testing)
Assignment: hw12
Description: Tests the dictionary class.
Author: Murtaza Jafferji
=end

require 'test/unit'

# Design a class to represent a dictionary
class Dictionary
  
  # We know that the dictionary starts out empty
  def initialize
    @dictionary = {}
  end

  # Don't know yet how I will represent info
  def empty?
    @dictionary.empty?
  end
 
  # Can translate from one language to another and back again 
  def add_translation(first, second)
    @dictionary[second] = first
    @dictionary[first] = second
  end

  # Remove translation 
  def remove_translation(word)
    translation = @dictionary[word]
    @dictionary.delete(word)
    @dictionary.delete(translation)
  end
  
  # Translate a word
  def translate(word)
    @dictionary[word]
  end
end

# Test the class as we develop it
class DictionaryTest < Test::Unit::TestCase
  
  def setup
    @dict = Dictionary.new
  end

  # Check that a new dictionary is empty
  def test_empty_dict
    assert @dict .empty?
  end

  # Check that once you add at least one translation it is not empty
  def test_adding_xlate
    @dict.add_translation("book", "boek")
    assert !@dict.empty?
  end

  # Check that I can fetch the translation I added
  def test_add_fetch_xlate
    @dict.add_translation("book", "boek")
    book = @dict.translate("boek")
    assert_equal "book", book, "expected translation to be book"
  end
  
  # Let's check two translations
  def test_add_two_xlates
    @dict.add_translation("book", "boek")
    @dict.add_translation("house", "huis")
    assert !@dict.empty?
    assert_equal "book", @dict.translate("boek")
    assert_equal "house", @dict.translate("huis")
  end

  # Check if it can be translated by multiple languages
  def test_multi_xlate
    assert @dict.empty?
    @dict.add_translation("book", "boek")
    assert !@dict.empty?
    assert_equal "book", @dict.translate("boek")
    assert_equal "boek", @dict.translate("book")
  end

  # Check if definitions can be removed
  def test_remove_xlate
    @dict.add_translation("book", "boek")
    @dict.remove_translation("book")
    assert_nil @dict.translate("book")
    assert_nil @dict.translate("boek")
  end
  
  # Check if accents work without problems
  def test_accents
    @dict.add_translation("book", "böek")
    assert !@dict.empty?
    assert_equal "book", @dict.translate("böek")
  end
end