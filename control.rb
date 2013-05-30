#! /usr/bin/env ruby

puts "Remote SSH Sender"
puts "-------"
puts "0. Custom SSH"
puts "1. DC Develop"
puts "2. DC Production"
#puts "3. DC Develop (Rails Console)"
#puts "4. DC Prodcution (Rails Console)"
#puts "5. "

choice = $stdin.gets.chomp.to_i

print "URL: " if choice == 0
custom = $stdin.gets.chomp.to_s if choice == 0

commands =
    [
    "#{custom}",
    "deploy@direct.develop.dynamiccreative.com",
    'deploy@direct.app.dynamiccreative.com; "cd /data/dynamiccreative/current/"',
    'deploy@direct.develop.dynamiccreative.com; "cd /data/dynamiccreative/current/; RAILS_ENV=develop bundle exec rails console"',
    'deploy@direct.app.dynamiccreative.com; "cd /data/dynamiccreative/current/; sudo RAILS_ENV=production bundle exec rails console"',
    'deploy@direct.staging.dynamiccreative.com'
]

exec("./open3.rb \"#{commands[choice]}\"")
