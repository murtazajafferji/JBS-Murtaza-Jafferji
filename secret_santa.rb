# Murtaza Jafferji
# JBS Prework
# 5/28/10
#
# Secret Santa
# This program is designed to take the names and email addresses of participants from a user 
#   and then choose a Secret Santa for every person in the list. Santas are selected with the
#   condition that someone's Santa is not part of his/her family. Each Santa is emailed
#   with the name of their future gift recipient. 
# Preconditions: Install tlsmail gem

# a person class to manage participant data
class Person
  attr_accessor :fname, :lname, :email
 
  def initialize(fname, lname, email)
    @fname = fname
    @lname = lname
    @email = email
  end
end
  
puts 'Enter the data (type "done" when finished)'
puts 'FIRST_NAME space FAMILY_NAME space <EMAIL_ADDRESS> newline' 
$people_array = Array.new
flag = true
  while flag
    line = gets.chomp
    if line.downcase == 'done'
      flag = false
    elsif line =~ /\w* \w* <\w*@\w*.\w*>/ #checks if data entered in correct format
      split_line = line.split #splits the line into an array of its components
      email_address = split_line[2].reverse.chop #deletes the "<" and ">" from the email address
      email_address = email_address.reverse.chop
      $people_array.push Person.new(split_line[0], split_line[1], email_address)
    else 
      puts "Invalid entry!"
    end
end

$pairs = $people_array.sort_by { rand } #creates a new array of participants in a random ordering

# returns true if a randomly sorted second array is ordered in such a way that corresponding 
# indices with the first array match two people without the same last name 
def match
  $people_array.each_with_index do |person, i|
    if person.lname.downcase == $pairs[i].lname.downcase
      return false
    end
  end
  return true
end

# randomly sort until an acceptable ordering is found
$pairs = $people_array.sort_by { rand } until match 

# prints each Santa's name with their future gift recipient
$people_array.each_with_index do |person, i|
  puts person.fname + " " + person.lname + " is " + $pairs[i].fname + " " + $pairs[i].lname + "'s Secret Santa."
end
  
# asks user for Gmail information for sending out emails
puts "\nEnter your Gmail username:"
@username = gets.chomp
puts "Enter your Gmail password:"
@password = gets.chomp

# sends an email to each Santa with the name of their future gift recipient
def send_email(santa, recipient)
  require 'tlsmail'  
  require 'time'  
  
content = <<EOF  
From: #{@username}
To: #{santa.email}
Subject: Hey #{santa.fname}! Secret Santa info inside.   
Date: #{Time.now.rfc2822}  
  
You are #{recipient.fname} #{recipient.lname}'s Secret Santa.
EOF
  
  Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)  
  Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', @username, @password, :login) do |smtp|  
    smtp.send_message(content, @username, santa.email)  
  end
end
 
# sends an email to each Santa
$people_array.each_with_index do |person, i|
  send_email(person, $pairs[i])
  
end