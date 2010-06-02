# Murtaza Jafferji
# HW1 - Exercise 3
# 6/1/10
#
# This program listens on port 8888 and when a client connects to it,
# it returns a fortune. Note: to see output, type "localhost:8888" into your browser.

require 'socket'               # Get sockets from stdlib
require 'exercise2.rb'         

f = Fortune.new                # Create a Fortune object

server = TCPServer.open(8888)  # Socket to listen on port 8888
loop {                         # Servers run forever
  client = server.accept       # Wait for a client to connect
  client.puts(f.next_fortune)  # Send the fortune to the client
  client.puts "Closing the connection. Bye!"
  client.close                 # Disconnect from the client
}
