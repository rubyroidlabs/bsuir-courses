expression = gets.chomp
stack_expression = expression.split(" ")
result_stack = []
stack_expression.each do |element|
  case element
  when "+"
    result_stack[-2] += result_stack.last
    result_stack.delete_at(result_stack.size - 1)
  when "-"
    result_stack[-2] -= result_stack.last
    result_stack.delete_at(result_stack.size - 1)
  when "*"
    result_stack[-2] *= result_stack.last
    result_stack.delete_at(result_stack.size - 1)
  when "/"
    result_stack[-2] /= result_stack.last
    result_stack.delete_at(result_stack.size - 1)
  else
    result_stack << element.to_i
  end
end
puts result_stack
