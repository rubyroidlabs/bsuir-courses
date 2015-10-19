#!/usr/bin/env ruby

i = 13

i.times do
  system 'clear'
  if i > 0
    i.times { puts '' }
    i -= 1
  end
  puts '   _'
  puts '  / \\'
  puts ' /___\\'
  puts ' |   |'
  puts ' | O |'
  puts ' |___|'
  puts '/_| |_\\'
  puts 'tt   tt'
  if i.odd?
    puts 't     t'
  else
    puts ' t   t '
  end
  sleep(1.0 / 4.0)
end
system 'clear'
