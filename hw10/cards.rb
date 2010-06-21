=begin
Name: Cards.rb
Assignment: hw10
Description: This program allows for cards to be added, deleted, changed, searched, viewed, and randomly created.
Author: Murtaza Jafferji
Preconditions: Must install httparty and terminal-table gem.
=end

require 'rubygems'
require 'httparty'
require 'terminal-table/import'

class CardUtil
  include HTTParty
  base_uri 'localhost:3000'

  # Add a card with a name (required) and phone numbers (optional)
  def add(name, home_phone = nil, office_phone = nil)
    options = {:name => name}
    options[:home_phone] = home_phone unless home_phone.nil?
    options[:office_phone] = office_phone unless office_phone.nil?
    options = {:body => {:card => options } }
    self.class.post("/cards.xml", options)
  end
 
  # Delete card with the specified name
  def delete(name)
    id = name_to_id(name)
    self.class.delete("/cards/#{id}.xml")
  end
  
  # View a specific person's card or all cards (by typing "all")
  def view(name)
    if name == 'all'
      response = self.class.get("/cards.xml")
      cards = response.parsed_response['cards']
    else
      id = name_to_id(name)
      response = self.class.get("/cards/#{id}.xml")
      cards = response.parsed_response['card']
    end
    table_view(cards)
  end
  
  # Change a card's fields
  def change(name, newname, new_home_phone = nil, new_office_phone = nil)
    id = name_to_id(name)
    options = { :name => newname }
    options[:home_phone] = new_home_phone unless new_home_phone.nil?
    options[:office_phone] = new_office_phone unless new_office_phone.nil?
    options = { :body => {:card => options} }
    self.class.put("/cards/#{id}.xml", options)
  end

  # Search for a card by a regular expression
  def search(regexp)
    cards = get_cards
    found = cards.select { |card| card['name'] =~ regexp }
    table_view(found)
  end

  # Creates a specified number of random cards
  def seed(int)
    int.to_i.times do
      add(random_name, random_number, random_number)
    end
  end
 
private

  # Return an array of all cards
  def get_cards
    self.class.get("/cards.xml").parsed_response['cards']
  end

  # Gets the id of the card with the specified name
  def name_to_id(name)
    all_cards = get_cards
    card = all_cards.detect {|c| c['name'] == name }
    if card.nil?
      return nil
    else
      return card['id']
    end
  end
  
  # Print the cards in a table.
  def table_view(cards)
    return if cards.nil?
    cards = [cards] unless cards.instance_of?(Array)
    card_table = table do |t|
      t.headings = cards.first.keys
      cards.each do |card|
        t << card.values
      end
    end
    puts card_table
  end

  # Gnerate a random name
  def random_name
  	chars = ("a".."z").to_a
	Array.new(7, '').collect{chars[rand(chars.size)]}.join
  end

  # Generate a random phone number
  def random_number
    chars = ("1".."9").to_a 
	Array.new(10, '').collect{chars[rand(chars.size)]}.join
  end

end

utility = CardUtil.new

if ARGV.empty?
  puts "Enter a command."
  exit 1
end

command = ARGV[0]

if command == 'add'
  name, home_phone, office_phone = ARGV[1..3]
  utility.add(name, home_phone, office_phone)
elsif command == 'delete'
  name = ARGV[1]
  utility.delete(name)
elsif command == 'view'
  name = ARGV[1]
  utility.view(name)
elsif command == 'change'
  name, newname, home_phone, office_phone = ARGV[1..4]
  utility.change(name, newname, home_phone, office_phone)
elsif command == 'search'
  regexp = Regexp.new(ARGV[1])
  utility.search(regexp)
elsif command == 'seed'
  int = ARGV[1]
  utility.seed(int)
else
  puts "#{command} is not a valid command."
end