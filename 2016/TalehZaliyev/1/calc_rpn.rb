#!/usr/bin/env ruby
require "./lib/numeric.rb"
def calc_rpn(stack = [])
  loop do
    case (input = gets.strip)
    when /^(\d+|\d+[.]\d+)$/ then stack.push(input)
    when %r{^[-+*\/!]$}
      input == "!" ? input = ".bit_rep " + stack.pop : input += " " + stack.pop
      stack.push(eval(stack.pop + ".to_f" + input).to_s)
      break if stack.size == 1
    end
  end
  stack
end
puts calc_rpn
