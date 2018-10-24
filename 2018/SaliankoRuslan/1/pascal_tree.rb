def pascal(n, number)
  line = [number]
  n.times do |k|
    line << (line[k].to_i * (n - k) / (k + 1))
  end
  line
end

def format_pascal(n, number)
  col = `/usr/bin/tput cols`.chomp.to_i
  pascal(n, number).to_s.center(col)
end

print 'Введите глубину дерева: '
n = gets.chomp.to_i
print 'Введите базовый номер: '
number = gets.chomp.to_i
n.times do |i|
  puts "#{i}: #{format_pascal(i, number)}"
end
