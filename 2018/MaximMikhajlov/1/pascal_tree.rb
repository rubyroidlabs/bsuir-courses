w_display = %x`tput cols`.to_i

puts 'Введите глубиу дерева'
deep = gets.to_i

if ENV['BASE_NUMBER'].nil?
  puts 'Введите базовый номер'
  base_number = gets.to_i
else
  base_number = ENV['BASE_NUMBER'].to_i
end

fact = -> (x) {(1..x).inject(:*) || 1}

(deep + 1).times do |i|
  arr = (0..i).map do |j|
    base_number * fact.call(i) / (fact.call(j) * fact.call(i - j))
  end
  str_elements = arr.join('  ')
  str = ' ' * i.to_s.length + '   '
  str += ' ' * ((w_display - str_elements.length) / 2)
  str += arr[1..-2].map{ |a| a.to_s.length }.map do |k| 
    (k > 2) ? '\\' + '_' * (k - 2) + '/' : '\\/'
  end.join("  ")
  puts str
  puts "#{i}" + ' ' * ((w_display - str_elements.length) / 2) + str_elements
end