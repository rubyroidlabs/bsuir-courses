#!/usr/bin/env ruby
require_relative 'quit'
require "curses"
include Curses
require 'terminfo'

max_length = 0

File.open("picture", "r") do |f|
  f.each do |i|
    if i.size >= max_length
      max_length = i.size
    else
      max_length = max_length
    end
  end
end


file = File.open("picture");
file_array = file.to_a
terminal_info = TermInfo.screen_size
lines = terminal_info[0]
columns = terminal_info[1]
file_array_temp = Array.new(file_array)
position = columns - max_length + 1


loop do
  (0..position).each do |i|
    sleep 0.05
    file_array_temp = file_array.map{ |item| ' '*(i%(columns-max_length + 1)) + item }
    puts file_array_temp    
  end

  break if quit?
end
