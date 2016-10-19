require 'pry'
def nulli( a , b)
    i = 0
    it = 0
    until i >= b
      it += 1 
      os = a % 2
      a = a / 2     
      if os == 1
        i += 1
      end    
    end  
    a = a * (2**it)  
    return a
end   
puts "polska calculator"
steck = []
loop do
  input = gets.chomp
  break if  input == ""
  case input 
  when "*"
     b = steck.pop
     a = steck.pop
     steck.push(a.to_f * b.to_f)
  when "+"
     b = steck.pop
     a = steck.pop
     steck.push(a.to_f + b.to_f)
  when "-"
     b = steck.pop
     a = steck.pop
     steck.push(a.to_f - b.to_f)
  when "/"
     b = steck.pop
     a = steck.pop
     steck.push(a.to_f / b.to_f)
  when "!"
    b = steck.pop
    a = steck.pop 
    steck.push(nulli(a.to_i , b.to_i))   
  else 
    input.to_f
    steck.push(input)
  end
end
if steck.length == 1
  puts "=> #{steck[0]}"
else puts "Error"
end
