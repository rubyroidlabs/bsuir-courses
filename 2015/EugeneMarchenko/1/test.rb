#!/usr/bin/env ruby

require "curses"
include Curses

picture_name = "picture"
max_size = 0
max_length = 0
temp_array = []
s_to_array = []

file = File.open(picture_name);
file_array = file.to_a
file_array.each do |i|
if i.size >= max_length
    max_length = i.size
  else
    max_length = max_length
  end
  max_size += 1
end

file_array.each do |i|
	
	
end

