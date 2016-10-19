#!/usr/bin/env ruby
# class RPNCalculator
class RPNCalculator
  def special_func(first, second)
    tmp_arr = ("0" + first.to_s(2)).split(//)
    index = (second * - 1) - 1
    (index..0).each { |i| tmp_arr[i] = "0"}
    result = "0" + tmp_arr.join('')
    result.to_i(2)
  end

  def evaluate(rpn)
    a = rpn.split(" ")
    array = a.inject([]) do |stack, i|
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
    p array.pop
  end
end
