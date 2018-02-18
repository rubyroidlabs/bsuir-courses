puts 'Enter deep'
deep = gets.chomp.to_i
puts 'Enter basic value'
basic_val = gets.chomp.to_i
pasc_tri = [[basic_val]]

pasc_tri.each do |i|
  ar = []
  pasc_tri.each do |j|
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

pasc_tri.each do |i|
  str = ''
  pasc_tri.each do |j|
    str += (pasc_tri[i][j].to_s + (' ' * ((size[1] - 1) / (deep * 2))))
    length = str.length
  end
  print ' ' * (size[1] / 2 - ((length - ((size[1] - 1) / (deep * 2))) / 2))
  puts str
end


