#!/usr/bin/env ruby

require "curses"
include Curses

picture_name = "picture_test"
max_size = 0
max_length = 0

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

# puts "max length: #{max_length}"
# puts "max size  : #{max_size}"

counter = 0

while counter < max_length - 1

  file_array.each_with_index do |var, index|
    temp_array = []
    var.each_char do |i|
      temp_array << i
    end

    puts temp_array[counter]
    
  end
  counter += 1
end