def calculate(first, second, operation)
  first = first.to_i
  second = second.to_i

  case operation
  when '+'
    first + second
  when '-'
    first - second
  when '/'
    first / second
  when '*'
    first * second
  when '!'
    binary_operator(first, second)
  else
    raise 'wrong operation, write corect value! '
  end
end

def binary_operator(first, second)
  #  (93,3) ( 01011101 ) -> (01010000 ) 80
  count = 1
  first.to_s(2).chars.reverse.map do |a|
    if count <= second && a == '1'
      count += 1
      '0'
    else
      a
    end
  end.reverse.join.to_i(2)
end

stack = []

puts 'Calculate: '
# 2 3 4 + -   => 5
loop do
  var = gets.chomp
  if var == var.to_i.to_s
    stack << var
  else
    new_stack = stack.pop(2)
    stack << calculate(new_stack[0], new_stack[1], var)
    break if stack.length == 1
  end
end

puts stack.first
