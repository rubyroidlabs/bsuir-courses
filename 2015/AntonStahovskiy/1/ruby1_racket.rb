#!/usr/bin/env ruby

i=13

13.times do
  system "clear"
  if i>0
    i.times { puts " " }
    i-=1
  end
  puts "
   _
  / \\
 /___\\
 |   |
 | O |
 |___|
/_| |_\\
tt   tt"
  if i%2==1
    puts "t     t"
  else
    puts " t   t "
  end
  sleep (1.0/4.0)
end
system "clear"
