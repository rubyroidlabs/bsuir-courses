require_relative "lib/polish_notation.rb"

stack = []
pn = PolishNotation.new

puts "Calculate: "
# 2 3 4 + -   => 5
loop do
  var = gets.chomp
  if var == var.to_i.to_s
    stack << var
  else
    new_stack = stack.pop(2)
    stack << pn.calculate(new_stack[0], new_stack[1], var)
    break if stack.length == 1
  end
end

puts stack.first
