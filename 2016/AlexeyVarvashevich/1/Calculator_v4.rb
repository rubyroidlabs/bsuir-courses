#!/usr/bin/env ruby

def calc(digits, operator)
  if "^" == operator
    digits[0] ** digits[1]
  else digits[0].send(operator, digits[1])
  end
end

def binar(num)
  a = num[0].to_i.to_s(2).reverse!.split("")
  a.map! do |cell|
    if cell == "1" && num[1].positive?
      num[1] -= 1
      "0"
    else cell
    end
  end
  a.reverse!.join.to_i(2)
end

puts "You're running a calculator based on RPN (Reverse Polish Notation).\n Enter expression separated by {Enter}. Supported operators '+ - / * ! ^'."
stack = []
flag = false
while stack.length > 1 || !flag
  element = gets.strip
  if /^[-]?\d(\d)*?$|^[-]?\d*\.{1}\d*$/ =~ element
    stack.push(element.to_f)
  elsif %w(+ - / * ^).include?(element) && stack.size > 1
    result = calc(stack.pop(2), element)
    stack.push(result)
    flag = true
  elsif "!" == element && stack.size > 1
    result = binar(stack.pop(2))
    stack.push(result)
    flag = true
  elsif stack.size <= 1
    puts "Not enough numbers to calculate. Please input number."
  else puts "'#{element}' contains incorrect symbols. Please input number or operator."
  end
end

if stack[0].to_s.split(".")[1] == "0"
  puts "Result is #{stack[0].to_i}"
else
  puts "Result is #{stack[0]}"
end
