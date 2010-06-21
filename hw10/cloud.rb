=begin
Name: Cloud.rb
Assignment: hw10
Description: This program creates folders with fortunes as their names on DigitalBucket.
Author: Murtaza Jafferji
Preconditions: Must enter DigitalBucket username and password into code.
=end

require 'rubygems'
require 'httparty'
require 'pp'
require 'Base64'

class FortuneCookieStore
  include HTTParty
  base_uri 'https://www.digitalbucket.net/api/rest'
  headers 'User-Authentication' => Base64.encode64("murtazajafferji@gmail.com:password")
  
  def initialize
    get_root_folder
  end
  
  def get_root_folder
    rt = self.class.get('/getrootfolder.axd')
    @root = Crack::XML.parse(rt.parsed_response)['Folder']['FolderID']

  end
  
  def create_folder_for_parent(parent, name)
    options = {:query => {'parentid' => parent, 'foldername' => name}}
    self.class.get('/createfolder.axd', options)
  end
  
  def create_folder(name)
    create_folder_for_parent(@root, name)
  end
  
end

class Fortune
  
  # an array of fortunes
  FORTUNES = {0 => "You will learn Ruby soon",1 =>  "You will get an A for this course",2 =>  "The Redsox will lose", 
              3 => "You will die",4 =>  "You will blink",5 =>  "It will rain one day",6 =>  "Tomorrow will be the day after today"}
  
  # initializes the array
  def initialize
    @seen = []
  end
  
  # selects a random, previously unseen fortune (if the number 
  # of calls is less than or equal to the number of fortunes)
  def next_fortune
  	random_number = (rand * FORTUNES.length).to_int
    fortune = FORTUNES[random_number] #picks a random fortune
    
    # prevents an infinite loop if the number of calls is more than the number of fortunes
    if (@seen.length >= FORTUNES.length)
      return fortune
    end
    
    # keeps randomly choosing fortunes until it finds an unseen one
    while (@seen.include?(fortune))
      random_number = (rand * FORTUNES.length).to_int
      fortune = FORTUNES[random_number]
    end
    
    @seen.push(fortune) #adds the chosen fortune to the list of seen fortunes
    return "#{random_number}####{fortune}"
  end

end

fc = FortuneCookieStore.new
f = Fortune.new
response = "y"
while (response =~ /^y/)
  fc.create_folder(f.next_fortune)
  print "Do you want create another folder (y/n)? "
  response = gets
end

