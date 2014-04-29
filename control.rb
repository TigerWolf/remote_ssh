#! /usr/bin/env ruby

puts "Remote SSH Sender"
puts "-------"
puts "0. Custom SSH"
puts "1. Server 1"
puts "2. Server 2"

choice = $stdin.gets.chomp.to_i

print "URL: " if choice == 0
custom = $stdin.gets.chomp.to_s if choice == 0

commands =
    [
    "#{custom}",
    "deploy@app.myapp.com  RAILS_ENV=production bundle exec rails console",
    "deploy@dev.myapp.com  RAILS_ENV=develop bundle exec rails console",
]

exec("./open3.rb \"#{commands[choice]}\"")
