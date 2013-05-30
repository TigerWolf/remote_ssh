#! /usr/bin/env ruby

require "readline"
require 'open3'
require 'io/console'

# Limitations:
# - Autocomplete for tab does not actually complete commands
# - Your key for the server will need to be added before running this command.

shortcuts = { 
  'dc' => 'cd /data/dynamiccreative/current; ls',
  'dcc' => 'cd /data/dynamiccreative/current; bundle exec rails c',
  #'dcl' => "cd /data/dynamiccreative/current; tail -f log/#{ENV['RACK_ENV']}.log " 
}

command = ARGV[0]
puts "Running 'ssh #{command}'"
Open3.popen3("ssh -tt #{command}") do |i, o, e, th|

  Thread.new {

    stty_save = `stty -g`.chomp
    trap('INT') { system('stty', stty_save); p 'Exiting remote terminal'; exit }

    Readline.completion_proc = Proc.new do |str|
      buff = Readline.line_buffer
      ""
    end

    while !i.closed? do
      input = Readline.readline("", true).strip
      if shortcuts.has_key?(input)
        i.puts shortcuts[input]
      else
        i.puts input
      end
    end
  }

  t_err = Thread.new {
    while !e.eof?  do
      putc e.readchar
    end
  }

  t_out = Thread.new {
    while !o.eof?  do
      putc o.readchar
    end
  }

  Process::waitpid(th.pid) rescue nil # "rescue nil" is there in case process already ended.

  t_err.join
  t_out.join

end



