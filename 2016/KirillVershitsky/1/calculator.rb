#!/usr/bin/env ruby

def calc(dig, operation)
  dig[0].send(operation, dig[1])
end

def bin_oper(digs)
  a = digs[0].to_i.to_s(2).reverse!.split("")
  a.map! do |el|
    if el == "1" && digs[1].positive?
      digs[1] -= 1
      "0"
    else
      el
    end
  end
  a.reverse!.join.to_i(2)
end

puts "Enter expression separate by {Enter}. Supports - / * + ! operators"
stack = []
flag = false
while stack.length > 1 || !flag
  element = gets.strip
  if /\d/ =~ element
    stack.push(element.to_f)
  elsif %w(+ - / * !).include?(element) && stack.size > 1
    rez = element != "!" ? calc(stack.pop(2), element) : bin_oper(stack.pop(2))
    stack.push(rez)
    flag = true
  else
    puts "Isn't correct input"
  end
end

puts "#=> #{stack[0]}"
