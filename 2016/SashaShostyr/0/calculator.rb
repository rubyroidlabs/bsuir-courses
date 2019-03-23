#!/usr/bin/env ruby

stack = []
p "Input expression(example:4 3 2 + *):"
loop do
  variable = gets.chomp
  if !(variable.to_s =~ /\d+/).nil?
    stack << variable.to_i
  else
    b = stack.pop(2)
    case variable
    when "+" then stack << b[0] + b[1]
    when "-" then stack << b[0] - b[1]
    when "*" then stack << b[0] * b[1]
    when "/" then stack << b[0] / b[1]
    when "!" then
      number = 0
      stack << b[0].to_s(2).chars.reverse.map do |bit|
        if number < b[1] && bit == "1"
          number += 1
          "0"
        else
          bit
        end
      end.reverse.join.to_i(2)
    else fail "Wrong data !!!"
    end
    break if stack.length == 1
  end
end
p stack.first
