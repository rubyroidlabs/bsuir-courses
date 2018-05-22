display_width = `tput cols`.to_i
CENTRAL_POSITION = 2

puts 'Введите глубиу дерева'
deep = gets.to_i

if ENV['BASE_NUMBER'].nil?
  puts 'Введите базовый номер'
  base_number = gets.to_i
else
  base_number = ENV['BASE_NUMBER'].to_i
end

fact = ->(x) { (1..x).inject(:*) || 1 }

(deep + 1).times do |level|
  arr = (0..level).map do |element_number|
    base_number * fact.call(level) /
      (fact.call(element_number) * fact.call(level - element_number))
  end
  str_elements = arr.join('  ')
  str = ' ' * level.to_s.length + '   '
  str += ' ' * ((display_width - str_elements.length) / CENTRAL_POSITION)
  length_elements = arr[1..-2].map { |element| element.to_s.length }
  str += length_elements.map do |length_element|
    length_element > 2 ? '\\' + '_' * (length_element - 2) + '/' : '\\/'
  end.join('  ')
  puts str
  puts level.to_s + ' ' * ((display_width - str_elements.length) /
    CENTRAL_POSITION) + str_elements
end
