def factorial(n)
  Math.gamma(n + 1).to_i
end

def pascalNumber(n, m)
  factorial(n) / (factorial(m) * factorial(n - m))
end

if ENV['BASE_NUMBER'].nil?
  puts "BASE_NUMBER пуста"
  return
end
base_number = ENV['BASE_NUMBER'].to_i
puts "Базовый номер: #{base_number}"

print "Введите глубину дерева: "
depth = gets.chomp.to_i


for i in 0..depth - 1
  print format("%3i:",i)
  for j in 0..i
    print format("%7i", pascalNumber(i,j) * base_number)
  end
  puts
end
