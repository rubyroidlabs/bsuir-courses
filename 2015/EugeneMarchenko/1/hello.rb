#!/usr/bin/env ruby
require "curses"
include Curses

picture_name = "picture_test_2"
max_size = 0
max_length = 0

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

init_screen
nl
noecho
curs_set(0)

ypos = lines / 2
xpos = cols


# while true do
  counter = 0
  while counter < max_size
    file_array.each_with_index do |var, index|
      temp_array = []
      var.each_char do |i|
        temp_array << i
      end
      setpos(ypos + index, xpos - counter); addstr (temp_array[counter])
      # puts temp_array[counter]
      refresh
    end
    counter += 1
  end
  clear
  sleep 8




  # file_array.each_with_index do |item, index|
  #   setpos((ypos + index) - max_size/2, xpos); addstr (item)
  #   refresh
  # end
  # clear
  # xpos -= 1
  # sleep 0.5
  
  
# end

