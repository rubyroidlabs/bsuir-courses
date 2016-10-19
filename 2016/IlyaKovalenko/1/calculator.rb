#!/usr/bin/env ruby
stack = []
gSymbol = false
begin
  lexem = gets
  if ["+", "-", "/", "*", "!", "^"].include? lexem.chr
    b = stack.pop
    a = stack.pop
    case lexem.chr
      when '+' then stack.push(a + b)
      when '-' then stack.push(a - b)
      when '*' then stack.push(a * b)
      when '^' then stack.push(a ** b)
      when '!' then
        bits = []
        a = a.to_i
        begin
          bits.push(a % 2)
          a /= 2
        end while (a > 0)
        bits.reverse!
        #puts bits
        i = 0
        while i < bits.length
          if (b > 0) && (bits[i] == 1)
            bits[i] = 0
            b -= 1
          end
          i += 1
        end
        i = 0
        result = 0
        while i < bits.length
          result += bits[i] * (2 ** i)
          i += 1
        end    
        stack.push(result)
      when '/' then 
        if b == 0 then
          puts "Division by zero. " + a.to_s + "/" + b.to_s
        else  
          stack.push(a / b)
        end
    end
    gSymbol = true
  else
    stack.push(lexem.to_f)
  end    
end while (!gSymbol) || (stack.length > 1)

puts "#=> " + stack.pop.to_s
