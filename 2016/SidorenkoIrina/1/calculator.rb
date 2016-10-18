operations = []
numbers = []
loop do 
  value = gets.chomp
    if (value == value.to_i.to_s)
       numbers.push(value.to_i)
     else 
        operations << value
     end
     break if (numbers.size == operations.size + 1 && numbers.size > 1)
end
  operations.each do |el|
  s = numbers.size
  case el
    when "+"
        if numbers.empty? then raise "Empty array!"
        else numbers[s-2] +=  numbers.pop()
          end
    when "-"
      if numbers.empty? then raise "Empty array!"
        else numbers[s-2] -= numbers.pop()
        end
    when "*"
       if numbers.empty? then raise "Empty array!"
        else numbers[s-2] *= numbers.pop()
        end
    when "/"
      if numbers.empty? then raise "Empty array!"
        else numbers[s-2] /= numbers.pop()
        end
    else 
      numbers.push(el.to_i)
  end 
end
puts "=> #{numbers.first}"