puts 'Enter deep'
deep = gets.chomp.to_i
puts 'Enter basic value'
basic_val = gets.chomp.to_i
pasc_tri = [[basic_val]]
 
(1..(deep - 1)).each do |i|
  ar = []
  (0..i).each do |j|
    if i == j || j.zero?
      ar.push(basic_val)
    else
      ar.push(pasc_tri[i - 1][j] + pasc_tri[i - 1][j - 1])
    end
  end
  pasc_tri.push(ar)
end

require 'io/console'
size = IO.console.winsize

(0..(deep - 1)).each do |i|
  str = ''
  (0..i).each do |j|
    str += (pasc_tri[i][j].to_s + (' ' * (size[1] / (deep * 2))))
  end
  puts (' ' * (size[1] / 2 - ((str.length - size[1] / (deep * 2)) / 2))) + str
end
