def sum(operand)
  return operand[0].to_f + operand[1].to_f
end

def multiplication(operand)
  return operand[0].to_f * operand[1].to_f
end

def division(operand)
  return operand[0].to_f / operand[1].to_f
end

def subtraction(operand)
  return operand[0].to_f - operand[1].to_f
end

def nulling(operand)
  counter = 0
  number_of_bits = 0
  until counter = operand[1] 
    if (operand[0] % 2) == 1
      counter += 1 
    end 
    operand[0] = operand[0] / 2
    number_of_bits += 1 
  end   
  return operand[0] * (2 ** number_of_bits)
end

reverse_polish_notation = []
puts "Dear User, please, input your expression ('.' symbol ends it):"
string = gets.chomp
reverse_polish_notation << string
until string == "."
  string = gets.chomp
  reverse_polish_notation << string
end
expression_operands = []
reverse_polish_notation.each do |element|
  case element
  when /\d/
    expression_operands << element.to_f
  when "+"
    expression_operands << sum(expression_operands.pop(2)).to_f
  when "-"
    expression_operands << subtraction(expression_operands.pop(2)).to_f
  when "*"
    expression_operands << multiplication(expression_operands.pop(2)).to_f
  when "/"
    expression_operands << division(expression_operands.pop(2)).to_f
  when "!"
    expression_operands << nulling(expression_operands.pop(2))
  end
end

puts "The answer of this expression is #{expression_operands[0]}"   
