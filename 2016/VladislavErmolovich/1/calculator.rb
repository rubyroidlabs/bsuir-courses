#! /usr/bin/env ruby

def is_num?(s)
  (Integer(s) rescue nil) || (Float(s) rescue nil)
end

array = []
functions_count = 0
operands_count = 0
until (operands_count - functions_count == 1) && (functions_count != 0)
  s = gets.chomp
  if (s.size == 1) && (['+','-','*','/'].include?(s))
    functions_count += 1
    array.push(s)
  elsif s = is_num?(s)
    operands_count += 1
    array.push(s)
  else puts "Incorrect input. Try Again"
  end
end
while array.size > 1 do
  i = 0
  while (i < array.size) && (not ['+','*','/','-'].include?(array[i]))
	i+=1
  end
  case array[i]
  when '+' 
    array[i-2] += array[i-1]
  when '*' 
    array[i-2] *= array[i-1]
  when '-'
    array[i-2] -= array[i-1]
  when '/'
    array[i-2] /= array[i-1]
  end
  array[i-1] = nil
  array[i] = nil
  array.compact!
 end
puts array[0] 
