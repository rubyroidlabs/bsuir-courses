#!/usr/bin/env ruby

def int?(str)
  /^\-?\d*$/ =~ str ? true : false
end

def float?(str)
  /^\-?\d*\.\d*$/ =~ str ? true : false
end

def operator?(str)
  %r'^(\+|\-|\*{1,2}|/|!)$' =~ str ? true : false
end

def execute_operator(a, b, op_line)
  case op_line
  when "!" then set_to_zero(a, b)
  when "+" then a + b
  when "-" then a - b
  when "*" then a * b
  when "/" then a / b
  end
end

def set_to_zero(a, b)
  bin = a.to_s(2)
  n = [b, bin.count('1')].min
  n.times { bin[bin.rindex("1")] = "0" }
  bin.to_i(2)
end

stack = []

loop do
  line = gets.strip

  break if line == "exit"

  if int? line
    stack.push(line.to_i)
  elsif float? line
    stack.push(line.to_f)
  elsif operator? line
    if stack.size < 2
      puts "Not enough numbers."
    else
      b = stack.pop
      a = stack.pop
      stack.push(execute_operator(a, b, line))
      puts "#=> #{stack.pop}" if stack.size == 1
    end
  else
    puts "Invalid input! Please, try again."
  end
end
