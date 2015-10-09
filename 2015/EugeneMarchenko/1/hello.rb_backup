#!/usr/bin/env ruby
require "curses"
include Curses

picture_name = "picture"
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

while true do
  file_array.each_with_index do |item, index|
    setpos((ypos + index) - max_size/2, xpos); addstr (item)
    refresh
  end
  clear
  xpos -= 1
  sleep 0.05
  if xpos == 0
    xpos = cols
  end
  
end

