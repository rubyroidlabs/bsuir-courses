def factorial(n)
  Math.gamma(n + 1).to_i # here we use Gamma Function for calculation  factorial
end

def pascal_number(level, number)
  factorial(level) / (factorial(number) * factorial(level - number))
  # Here we use formula for a cell of Pascal's triangle
end

print 'Введите глубину дерева: '
depth = gets.chomp.to_i

(0...depth).each do |level|
  print format('%3i:', level)
  (0..level).each do |number|
    print format('%7i', pascal_number(level, number))
  end
  puts ''
end
