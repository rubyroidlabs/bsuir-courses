#!/usr/bin/env ruby
WIDTH = 20


file = File.open("crab");
crab_arr = file.to_a
crab_rev = []
crab_arr.each{ |item| crab_rev << ' '*WIDTH + item.chomp.reverse! }
puts crab_rev
crab_temp = Array.new(crab_arr)

direction = true
(0..1000).each do |i|
  puts crab_temp
  sleep 0.05
  if direction == true
    crab_temp = crab_arr.map{ |item| ' '*(i%WIDTH)+item }
  else
    crab_temp = crab_rev.map{ |item| item[i%WIDTH..item.length-1] }    
  end 
  
  if (i % WIDTH == WIDTH-1) then
    direction = !direction
    crab_temp.clear
    if direction == true then
      crab_temp = Array.new(crab_arr)
    else
      crab_temp = Array.new(crab_rev.dup)
    end
  end  
end

