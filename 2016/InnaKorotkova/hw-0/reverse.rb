#1/usr/bin/env ruby

operators = ['*','/','+','-','!']
flag = true
count = 0
values = []
stack = [] 
def bitoperation(value, count)
  if (code = value.to_i.to_s(2)).length <= count || count <= 0 
    p "incorrect argument"
    result = 0
  else
    code = code.reverse
    for i in 0...code.length
      if count.nonzero? && code[i] == "1" 
        code[i] = "0"
        count -= 1
      end
    end
    code.reverse.to_i(2)
  end
end

def operation!(symbol, stack)
  var = stack.pop
  case symbol
  when "*" then stack[stack.length - 1] = stack[stack.length - 1] * var
  when "-" then stack[stack.length - 1] = stack[stack.length - 1] - var
  when "+" then stack[stack.length - 1] = stack[stack.length - 1] + var
  when "/" then stack[stack.length - 1] = stack[stack.length - 1].to_f / var.to_f
  when "!" then stack[stack.length - 1] = bitoperation(stack[stack.length - 1], var)
  end
end
while flag
  if (value = gets.chomp).match(/^\d+$/)
    values.push(value = value.to_i)
    count += 1	
  else if operators.include?(value)
    count -= 1
    values.push(value)
    if count == 1 || count <= 0
      flag = false
    end 		
  end
end 
values.each { |x| operators.include?(x) ? operation!(x, stack) : stack.push(x) }
print stack[0], "\n"
