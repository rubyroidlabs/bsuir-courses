def fact(n)
  (1..n).inject(1, :*)
end

def binom(n, k)
  fact(n) / (fact(k) * fact(n - k))
end

def pascals_row(row, first_el)
  (0..row).map { |line| first_el * binom(row, line) }
end

puts 'Введите глубину дерева:'
three_len = gets.chomp.to_i
puts 'Введите базовый номер:'
first_el = gets.chomp.to_i
# to output a number with zeros in the beginning if its
# length is less than the length of the maximum element
number_max_len = pascals_row(three_len, first_el).max.to_s.length
console_len = 160
gaps = (' ' * number_max_len)
help_str = "\/#{gaps}\\#{gaps}" # Specifying a Tree Display Template
(0..three_len).each do |i|
	str = '' # to create an output line on the console of each line of the tree
  pascals_row(i, first_el).each do |elem|
  	str += elem.to_s.rjust(number_max_len, '0') + (gaps + '  ')
  end
  help1 = ' ' * three_len.to_s.length
  puts help1 + (help_str * i).chomp(gaps).center(console_len)
  help2 = i.to_s.rjust(three_len.to_s.length, '0')
  puts help2 + str.chomp(gaps + '  ').center(console_len, ',')
end
