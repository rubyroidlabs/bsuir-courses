#!/usr/bin/env ruby

def calc(dig, op)
  dig[0].send(op, dig[1])
end

puts "Enter expression separated by {Enter}. Supported operators '+ - / *'."
stack = []
flag = false
while stack.length > 1 || !flag
  element = gets.strip
  if /\d/ =~ element
    stack.push(element.to_f)
  elsif %w(+ - / * !).include?(element) && stack.size > 1
    result = calc(stack.pop(2), element)
    stack.push(result)
    flag = true
  else puts 'Incorrect input.Enter the correct value.'
  end
end

if stack[0].to_s.split('.')[1] == '0'
  puts "Result is #{stack[0].to_i}"
else
  puts "Result is #{stack[0]}"
end
