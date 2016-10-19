#!/usr/bin/env rubys
class RPNCalculator
  def special_func(first, second)
    tmp_str = "0" + first.to_s(2)
    tmp_array = tmp_str.split(//)
    index = (second * - 1) - 1
    while index < 0
      tmp_array[index] = "0"
      index += 1
    end
    result = "0" + tmp_array.join('')
    result.to_i(2)
  end
  def evaluate(rpn)
    a = rpn.split(' ')
    stack = a.inject([]) do |array, i|
      if i =~ /\d+/
        stack << i.to_i
      else
        b = stack.pop(2)
        case
        when i == "+" then stack << b[0] + b[1]
        when i == "-" then stack << b[0] - b[1]
        when i == "*" then stack << b[0] * b[1]
        when i == "/" then stack << b[0] / b[1]
        when i == "!" then stack << special_func(b[0], b[1])
        end
      end
    end
   p stack.pop
  end
end
