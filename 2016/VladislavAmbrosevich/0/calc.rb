#!/usr/bin/env ruby
arr = []
sign = ["+", "-", "*", "/", "!", "%"]
nums = 0
signs = 0

def check_result(num)
  num - num.to_i < 1E-20 ? num.to_i : num
end

def zeroing(num, i)
  count = 0
  shifts = 0
  while count < i
    num[0] == 1 ? (count += 1 && shifts += 1) : shifts += 1
    num = num >> 1
  end
  num = num << shifts
  num
end

loop do
  elem = gets.chomp
  if sign.include?(elem)
    signs += 1
    arr = arr.push(elem)
  else
    nums += 1
    arr = arr.push(elem.to_f)
  end
  break if (nums > 1) && (signs == nums - 1)
  if sign.include?(arr[0]) || sign.include?(arr[1])
    puts "Unexpected expression"
    exit
  end
end
while arr.size > 1
  i = 0
  i += 1 while !sign.include?(arr[i]) && (i < arr.size)
  case arr[i]
  when "+"
    arr[i - 2] = (arr[i - 2] + arr[i - 1]).to_f
  when "-"
    arr[i - 2] = (arr[i - 2] - arr[i - 1]).to_f
  when "*"
    arr[i - 2] = (arr[i - 2] * arr[i - 1]).to_f
  when "!"
    arr[i - 2] = zeroing(arr[i - 2].to_i, arr[i - 1].to_i).to_f
  when "/"
    if arr[i - 1].zero?
      puts "Division by zero"
      exit
    end
    arr[i - 2] = (arr[i - 2].to_f / arr[i - 1].to_f).to_f
  when "%"
    if arr[i - 1].zero?
      puts "Division by zero"
      exit
    end
    arr[i - 2] = (arr[i - 2].to_f % arr[i - 1].to_f).to_f
  end
  arr[i - 1] = nil
  arr[i] = nil
  arr = arr.compact
end
puts "Result: #{check_result(arr[0])}"
