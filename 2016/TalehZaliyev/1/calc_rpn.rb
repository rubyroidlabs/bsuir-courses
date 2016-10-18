#!/usr/bin/env ruby
class Numeric
  def bit_rep(num_bit)
    a = self - self.to_i
    self.to_i.to_s(2).split('').reverse.map do |x|
      (x == "1" && num_bit>0) ? ((num_bit -= 1) && (x = "0")) : x
    end.reverse.join.to_i(2) + a
  end
end
def calc_rpn(stack = [])
  while(true)
    case(input = gets.strip)
    when %r{^(\d+|\d+[.]\d+)$}; stack.push(input)
    when %r{^[-+*\/!]$}
      input == "!" ? input = ".bit_rep " + stack.pop : input += " " + stack.pop
      stack.push(eval(stack.pop + ".to_f" + input).to_s)
      break if stack.size == 1
    end
  end
  stack
end
puts calc_rpn
