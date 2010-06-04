=begin
Name: My Client
Assignment: hw2
Description: Sends input to My Server
Author: Murtaza Jafferji
=end

require 'socket'

# open socket to MyServer, listening on localhost:8888
tcp_socket = TCPSocket.open('localhost', 8888)

loop do
  print "> "
  command_string = gets
  break if command_string =~ /quit/
  tcp_socket.puts command_string #send command to server
  servers_resp = tcp_socket.readline #get response from server
  puts servers_resp.to_s #prints response
end
