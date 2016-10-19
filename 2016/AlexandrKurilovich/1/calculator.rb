#!/usr/bin/env ruby
class String #:nodoc:
  def operator?
    true if %r{^[\+\-\/\*!]+$} =~ self
  end

  def number?
    !(self =~ /^-?\d+(\.\d*)?$/).nil?
  end

  def valid?
    true if operator? || number?
  end
end

def reset(a, b)
  a = a.to_i.to_s(2).reverse
  b.to_i.times { a[a.index("1")] = "0" }
  a.reverse.to_i(2)
end

numbers = 0
operators = 0
expr = []

while numbers - operators != 1 || operators.zero?
  str = gets.chomp
  if str.valid?
    expr.push(str)
    p str
    numbers += 1 if str.number?
    operators += 1 if str.operator?
  else
    puts "Wrong input"
  end
end

stack = []
res = 0
expr.each do |x|
  if x.number?
    stack.push x.to_f
  else
    b = stack.pop
    a = stack.pop
    case x
    when "+"
      res = a + b
    when "-"
      res = a - b
    when "*"
      res = a * b
    when "/"
      res = a / b
    when "!"
      res = reset(a, b)
    end
    stack.push res
  end
end
puts "result: #{res}"
