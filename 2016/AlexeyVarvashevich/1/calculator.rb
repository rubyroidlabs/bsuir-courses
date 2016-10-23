#!/usr/bin/env ruby

def calc(dig, op)
  dig[0].send(op, dig[1])
end

def binar(num)
  a = num[0].to_i.to_s(2).reverse!.split("")
  a.map! do |cell|
    if cell == "1" && num[1].positive?
      num[1] -= 1
      "0"
    else
      cell
    end
  end
  a.reverse!.join.to_i(2)
end

puts "Enter expression separated by {Enter}. Supported operators '+ - / *'."
stack = []
flag = false
while stack.length > 1 || !flag
  element = gets.strip
  if /[A-Za-z]/ =~ element
    puts "'#{element}' contains incorrect symbols. Please input number or operator."
  elsif /\d/ =~ element
    stack.push(element.to_f)
  elsif %w(+ - / *).include?(element) && stack.size > 1
    result = calc(stack.pop(2), element)
    stack.push(result)
    flag = true
  elsif "!" == element && stack.size > 1
    result = binar(stack.pop(2))
    stack.push(result)
    flag = true
  elsif stack.size <= 1
    puts "Not enough numbers to calculate. Please input number."
  else puts "Incorrect input.Enter the correct value."
  end
end

if stack[0].to_s.split(".")[1] == "0"
  puts "Result is #{stack[0].to_i}"
else
  puts "Result is #{stack[0]}"
end
