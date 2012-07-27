# encoding: utf-8

require 'rubygems'
require 'smart_colored'

# clear screen
puts "\e[H\e[2J"

SPECIAL_CHARS = ""

def colorize line
  line.force_encoding 'UTF-8'
  line.gsub(/[@.,:+-=*\/]*/) { |c| c.colored.yellow }
end

def type_effect line
  line.each_char do |c|
    print c
    sleep 0.1
  end
end

begin
  # output content from file
  File.open 'source_sample.rb' do |src|
    src.lines.each do |line|
      type_effect colorize line
      sleep 0.2
    end
  end while true
rescue Interrupt => e # don't send ctrl c exception to terminal
  puts "\e[H\e[2J"
end
