#!/usr/bin/env ruby
require "./lib/numeric.rb"
stack = []
loop do
  case (input = gets.strip)
  when /^([-]?(\d+|\d+[.]\d+))$/ then stack.push(input)
  when %r{^[-+*\/!]$}
    next puts "add operand, please" if stack.size < 2
    input = "bit_rep" if input == "!"
    stack.push(stack.pop(2).map(&:to_f).inject(input.to_sym))
    break if stack.size == 1
  else puts "Enter smth valid"
  end
end
puts stack
