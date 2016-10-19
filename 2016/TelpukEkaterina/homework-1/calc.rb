def get_answer(value_arr, operation)
  a = value_arr[0]
  b = value_arr[1]

  case operation
  when "+" then a + b
  when "-" then a - b
  when "*" then a * b
  when "/" then a / b
  when "!" then binary_operator(a, b)
  else fail "Error!"
  end
end

def binary_operator(num, bit_count)
  binary_rev_num = num.to_s(2).reverse
  bit_count.times do
    binary_rev_num.sub!("1", "0")
  end
  binary_rev_num.reverse.to_i(2)
end

stack = []
puts "Write: "

loop do
  temp = gets.chomp
  if temp =~ /\A[-+]?\d*\.?\d+\z/
    stack.push(temp.to_i)
  else
    stack.push(get_answer(stack.pop(2), temp))
    break if stack.size <= 1
  end
end

puts stack.first
