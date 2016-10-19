def main
 stack = []
 while(true)
 tmp = gets.chomp
  case tmp
   when /\d/
    stack.push(tmp.to_f)
   when "-"
    if stack.size < 2
     puts 'error'
     break;
    end
    operand_2 = stack.pop
    operand_1 = stack.pop
    stack.push(operand_1 - operand_2)
   when "+"
    if stack.size < 2
     puts 'error'
     break;
    end
    operand_2 = stack.pop
    operand_1 = stack.pop
    stack.push(operand_1 + operand_2)
   when "*"
    if stack.size < 2
     puts 'error'
     break;
    end
    operand_2 = stack.pop
    operand_1 = stack.pop
    stack.push(operand_1 * operand_2)
   when "/"
    if stack.size < 2
     puts 'error'
     break;
    end
    operand_2 = stack.pop
    operand_1 = stack.pop
    stack.push(operand_1 / operand_2)
   when "="
    result = stack.pop
    break;
   end
  end
 puts result 
end
puts main

