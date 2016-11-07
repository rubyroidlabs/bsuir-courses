def nul(a, b)
 a = a.to_i.to_s(2).reverse
 b.to_i.times { a[a.index("1")] = "0" }
 a.reverse.to_i(2)
end

def calc(a, b, operation)
 case operation
 when %r{\+}
  return a + b
 when %r{\-}
  return a - b
 when %r{\*}
  return a * b
 when %r{\/}
  return a / b
 when %r{\!}
  return nul(a, b)
 end
end

puts "Type OPZ for calculating "
exp = []
loop do
 item = gets.chomp
 if item.include? "=" 
  stack = []
  exp.each do |element|
   operand = stack.pop(2)
   stack.push calc(operand[0],operand[1],element)
   res = stack.pop 
   puts "Result: #{res}"
  end 
  exp.clear
  next
 end
end