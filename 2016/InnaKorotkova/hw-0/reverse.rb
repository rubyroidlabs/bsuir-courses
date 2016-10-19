# 1/usr/bin/env ruby

operators = ["*", "/", "+", "-", "!"]
flag = true
count = 0
values = []
stack = []
def bitoperation(value, count)
  code = value.to_i.to_s(2).reverse
  if code.length > count && count.positive?
    code.each_char do |i|
      if count.nonzero? && code[i] == "1"
        code[i] = "0"
        count -= 1
      end
    end
  end
  count <= code.length ? code.reverse.to_i(2) : 0
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
  elsif operators.include?(value)
    count -= 1
    values.push(value)
    flag = false if count == 1 || count <= 0
  end
end
values.each { |x| operators.include?(x) ? operation!(x, stack) : stack.push(x) }
print stack[0], "\n"
