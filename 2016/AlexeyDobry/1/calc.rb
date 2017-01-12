#!/usr/bin/env ruby
 class String
  def operation?
    true if /^[\+\-\/\*!]+$/.match(self)
  end

  def number?
    true if Float self rescue false
  end

  def valid?
    true if self.operation? || self.number?
  end
 end

 def nul(a, b)
  a = a.to_i.to_s(2).reverse
  b.to_i.times { a[a.index("1")] = "0" }
  a.reverse.to_i(2)
 end

 def calc(b, a, operation)
  case operation
   when "+"
     return a + b
   when "-"
     return a - b
   when "*"
     return a * b
   when "/"
     return a / b
   when "!"
     nul(a, b)
  end
 end

 exp = [] 
 numbers = 0
 operators = 0
 
 while numbers - operators != 1 || operators.zero?
  vir = gets.chomp
  if vir.valid?
    exp.push(vir)
    p vir
    numbers += 1 if vir.number?
    operators += 1 if vir.operation?
  else
    puts " __Try smth else!__ =^.^=  "
  end
 end

 result = 0
 steck = []
 exp.each do |x|
  if x.number?
    steck.push x.to_f
  else
    result = calc(steck.pop, steck.pop, x)
    steck.push result
  end
 end
puts "Anwser: #{result}"
