=begin
Name: My Server
Assignment: hw2
Description: A web server which awaits a connection over port 8888.
Author: Murtaza Jafferji
=end

require 'gserver'

# array of fortunes
FORTUNES = ["You will learn a lot", "You will get an A", "You still have much to learn, Grasshopper"]

class MyServer < GServer
  def initialize(*args)
    super(*args)    
    @@client_id = 0
    
    # hash of jokes
    @jokes = {
      "en" => "What do you get when you take the circumference of a jack-o-lantern and divide it by its diameter? Pumpkin pi.",
      "es" => "Hay tres clases de personas: las que saben contar y las que no."
    }
  end
  
  def serve(io_object)
    @@client_id += 1 #each time serve is called, the class variable @@client_id is incremented by 1
    my_client_id = @@client_id
    io_object.sync = true
    
    puts("Client #{@@client_id} attached.")
    
    loop do
      line = io_object.readline.chomp #added chomp to take out \n
      string = case line
      when /^(t|time)$/ #when 't' or 'time' is entered
        "The time of day is #{Time.now}"
      when /^x/ #when 'x' is entered
        puts "Exiting!"
        break
      when %r{^(f|message/fortune)$} #when 'f' or 'message/fortune' is entered
        FORTUNES[FORTUNES.length * rand] #outputs a random fortune to the IO object
      when 'date' #when 'date' is entered
        Time.new.strftime("%D %r")
      when /^d(.+)/ #when a file name is entered which begins with a 'd'
        file = $1
        if File.exist?(file)
          File.read(file) #read the file
        else
          "Error: file does not exist."
        end
      when %r{^message/joke(?:\?lang=(.+))?$} #when message/joke or message/joke?lang=.. is entered
        if $1.nil? #if it's just message/joke, return the English joke
          @jokes["en"]
        elsif @jokes.key?($1) #return the joke of the specified language
          @jokes[$1]
        else #if the joke does not exist in specified language, give English one
          @jokes["en"]
        end
      else #if none of the above are entered
        puts "received line #{line}"
        "What does #{line} mean anyway?"
      end
      io_object.puts(string)
    end
  end
end

puts "Starting to listen for a connection on port 8888"
server = MyServer.new(8888)
server.start
server.join