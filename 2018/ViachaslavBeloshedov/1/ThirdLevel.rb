def factorial(n)
  Math.gamma(n + 1).to_i # here we use Gamma Function for calculation  factorial
end

def pascal_number(level, number)
  factorial(level) / (factorial(number) * factorial(level - number))
  # Here we use formula for a cell of Pascal's triangle
end

def print_triangle(base_number, depth, width_of_terminal)
  length_of_base_number = base_number.digits.count
  (0...depth).each do |level|
    print format('%2i:', level)
    print ' ' * (width_of_terminal - (length_of_base_number + 2) * level)
    print base_number, ' ' * (length_of_base_number + length_of_base_number - 1)
    (1..level).each do |number|
      print format('%5i', pascal_number(level, number) * base_number)
      print ' ' * length_of_base_number
    end
    print "\n"
  end
end

if ENV['BASE_NUMBER'].nil?
  puts 'BASE_NUMBER пуста'
  return
end

base_number = ENV['BASE_NUMBER'].to_i
puts "Базовый номер: #{base_number}"

print 'Введите глубину дерева: '
depth = gets.chomp.to_i

width_of_terminal = `tput cols`.to_i / 2

print_triangle(base_number, depth, width_of_terminal)
