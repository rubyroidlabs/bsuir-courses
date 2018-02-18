def fact(n)
  (1..n).inject(1, :*)
end

def binom(n,k)
  fact(n) / ( fact(k) * fact(n-k) )
end

def pascals_row(row, first_el)
  (0..row).map { |line| first_el * binom(row, line) }
end

puts "Введите глубину дерева:"
three_len = gets.chomp.to_i
puts "Введите базовый номер:"
first_el = gets.chomp.to_i

number_max_len = pascals_row(three_len, first_el).max.to_s.length #для вывода числа с нулями в начале, если его длинна меньше длинны максимального элемента
console_len = 160  # для центрирования дерева, значение для монитора 15" и разрешения 1366 х 768
gaps = (" " * (number_max_len)) #для формирования отображения в консоле
help_str = "\/#{gaps}\\#{gaps}" #задание шаблона отображения ветвей дерева
(0..three_len).each do |i| 
  str = "" #для создания строки вывода на консоль каждой строчки дерева
  pascals_row(i, first_el).each do
   |elem| str += elem.to_s.rjust(number_max_len, '0') + (gaps + "  ")
  end
  puts "#{" " * three_len.to_s.length}" + (help_str * i).chomp(gaps).center(console_len) #ветви
  puts "#{i.to_s.rjust(three_len.to_s.length, '0')}" + str.chomp(gaps + "  ").center(console_len, ",") #элементы
end
 