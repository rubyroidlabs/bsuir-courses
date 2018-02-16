def factorial(n)
  Math.gamma(n + 1).to_i
end

def pascalNumber(n, m)
  factorial(n) / (factorial(m) * factorial(n - m))
end

print "Введите глубину дерева: "
depth = gets.chomp.to_i
for i in 0..depth - 1
  print format("%3i:",i)
  for j in 0..i
    print format("%7i", pascalNumber(i,j))
  end
  puts
end
