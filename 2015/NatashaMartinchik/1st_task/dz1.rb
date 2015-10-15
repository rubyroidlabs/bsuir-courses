#!/usr/bin/env ruby
WIDTH = 70
loop do
  file = File.open ('ris.txt')
  mass = file.to_a
  rev = mass.map { |p| ' ' * WIDTH + p.chomp }
  WIDTH.times do |i|
    mass.map { |f| f.insert(0, ' ') }
    puts mass
    sleep 0.1
    puts "\e[H\e[2J"
    i + 1
  end
  g = 2
  while g < WIDTH
    i = 0
    while i <= WIDTH - g
      rev.map! { |n| n.insert(0, ' ') }
      i += 1
    end
    puts rev
    sleep 0.1
    puts "\e[H\e[2J"
    rev.map! &:lstrip!
    g += 1
  end
end
