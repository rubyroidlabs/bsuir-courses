def binary(num, power, counter1, counter2)
  l_num = num
  while counter1 < power && num > 0
    if l_num.divmod(2)[1] == 1
      num -= 2**counter2
      counter1 += 1
    end
    l_num = l_num.divmod(2)[0]
    counter2 += 1
  end
  num
end
oper_arr = ["+\n", "-\n", "*\n", "/\n", "!\n"]
stack = []
k = 0
loop do
  local = gets
  if oper_arr.include?(local.to_s)
    case local.to_s
    when "+\n"
      stack[-2] = stack[-2] + stack[-1]
    when "-\n"
      stack[-2] = stack[-2] - stack[-1]
    when "*\n"
      stack[-2] = stack[-2] * stack[-1]
    when "/\n"
      stack[-2] = stack[-2] / stack[-1]
    when "!\n"
      stack[-2] = binary stack[-2], stack[-1], 0, 0
    end
    stack.delete_at(stack.length - 1)
  else
    stack.push(local.to_i)
  end
  puts "Stack = #{stack}"
  k += 1
  break if stack.length <= 1 && k != 1
end
puts "Result = #{stack[0]}"
