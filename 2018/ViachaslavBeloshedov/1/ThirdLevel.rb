def factorial(n)
  Math.gamma(n + 1).to_i
end

def pascalNumber(n, m)
  factorial(n) / (factorial(m) * factorial(n - m))
end

def printTriangle(base_number, depth, length_of_terminal)
  begin
  length_of_base_number = base_number.digits.count
  for i in 0 .. depth - 1 
    print format("%2i:",i)
    print ' ' * (length_of_terminal - (length_of_base_number + 2) * i )
    print base_number, ' ' * (length_of_base_number + length_of_base_number - 1)
    for j in 1 .. i
      print format("%5i", pascalNumber(i,j) * base_number)
      print ' ' * length_of_base_number
    end
  puts
  end
rescue ArgumentError => e
  raise "Больше нет места для вывода."
end
end

if ENV['BASE_NUMBER'].nil?
  puts "BASE_NUMBER пуста"
  return
end

base_number = ENV['BASE_NUMBER'].to_i
puts "Базовый номер: #{base_number}"

print "Введите глубину дерева: "
depth = gets.chomp.to_i

length = %x[tput cols].to_i / 2

printTriangle(base_number,depth,length)
