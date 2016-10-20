#!/usr/bin/env ruby
arr = []
sign = ["+", "-", "*", "/", "!", "%"]
nums = 0
signs = 0
class String
  def valid_float?
    true if Float self rescue false
  end
end
def Checking sym
  signs = ["+", "-", "*", "/", "!", "%"]
  signs.include?(sym) || sym.valid_float?
end
def CheckResult num
  if num - num.to_i < 1E-20
    num = num.to_i
  end
  num
end
def Zeroing num, i
  count = 0
  shifts = 0
  while count < i
    if num[0] == 1
      count += 1
      shifts += 1
      num = num >> 1
    else
      shifts += 1
      num = num >> 1
    end
  end
  num = num << shifts
  num
end
while true
  elem = gets.chomp
  if Checking(elem)
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
  else
    puts "Invalid input, try again"
  end
end
while arr.size > 1
  i = 0
  while !sign.include?(arr[i]) && (i < arr.size)
    i += 1
  end
  case arr[i]
  when "+"
    arr[i - 2] = (arr[i - 2] + arr[i - 1]).to_f
  when "-"
    arr[i - 2] = (arr[i - 2] - arr[i - 1]).to_f
  when "*"
    arr[i - 2] = (arr[i - 2] * arr[i - 1]).to_f
  when "!"
    arr[i - 2] = Zeroing(arr[i - 2].to_i, arr[i - 1].to_i).to_f
  when "/"
    if arr[i-1].zero?
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
puts "Result: #{CheckResult(arr[0])}"
