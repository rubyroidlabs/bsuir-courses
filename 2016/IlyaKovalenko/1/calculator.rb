#!/usr/bin/env ruby

def del_bits(bits, b)
  bits.map! do |bit|
    if b.positive? && bit.to_i.positive?
      b -= 1
      bit = "0"
    end
    bit
  end
  bits
end

stack = []
got_operation = false
loop do
  lexem = gets.chomp
  if ["+", "-", "/", "*", "!", "^"].include? lexem.chr
    got_operation = true
    b = stack.pop
    a = stack.pop
    case lexem.chr
    when "+" then stack.push(a + b)
    when "-" then stack.push(a - b)
    when "*" then stack.push(a * b)
    when "^" then stack.push(a**b)
    when "!" then stack.push(del_bits(a.to_i.to_s(2).split("").reverse, b).reverse.join("").to_i(2).to_s(10).to_i)
    when "/" then b.zero? ? (puts "Division by zero.") : stack.push(a / b)
    end
  else
    stack.push(lexem.to_f)
  end
  break if (stack.length == 1) && got_operation
end

puts "#=> " + stack.pop.to_s
