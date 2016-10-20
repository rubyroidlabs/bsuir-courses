#! /usr/bin/env ruby

def is_num?(s)
  (Float(s) rescue nil)
end

array = []
functions_count = 0
operands_count = 0
functions_array = ["+","-","*","/"]

until (operands_count - functions_count == 1) && (functions_count != 0) do
  s = gets.chomp
  if (s.size == 1) && (functions_array.include?(s))
    functions_count += 1
    array.push(s)
  elsif is_num?(s) 
    operands_count += 1
    s = is_num?(s)
    array.push(s)
  else puts "Incorrect input. Try Again"
  end
  if operands_count <= functions_count
    puts "Your expression is incorrect. Check operands' and operations' count"
    exit
  end
end

while array.size > 1 do
  i = 0
  while (i < array.size) && (!functions_array.include?(array[i]))
    i+=1
  end
  case array[i]
  when "+"
    array[i - 2] += array[i - 1]
  when "*"
    array[i - 2] *= array[i - 1]
  when "-"
    array[i - 2] -= array[i - 1]
  when "/"
    if array[i - 1].nonzero?
      array[i - 2] /= array[i - 1]
    else
      puts "Division by zero is not allowed"
      exit
    end
  end
array[i - 1] = nil
array[i] = nil
array.compact!
end
puts array[0]
