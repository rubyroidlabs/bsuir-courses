def kill_one_bits(count, number)
  str = number.to_s(2).reverse
  str.length.times do |i|
    break if count <= 0
    if str[i] == "1"
      str[i] = "0"
      count -= 1
    end
  end
  str.reverse.to_i(2)
end

expression = []
puts "Enter '=' if you want to calculate your expression! ('q' - exit)"
loop do
  item = gets.chomp
  if item.include? "="
    stack = []
    expression.each do |element|
      stack.push case element
                 when /\d/ then element.to_i
                 when /\+/ then stack.pop + stack.pop
                 when /\-/
                   operands = stack.pop(2)
                   operands[0] - operands[1]
                 when /\*/ then stack.pop * stack.pop
                 when %r{\/}
                   operands = stack.pop(2)
                   operands[0] / operands[1]
                 when /\!/ then kill_one_bits(stack.pop, stack.pop)
                 end
    end
    puts "Result: #{stack.pop}"
    expression.clear
    next
  elsif item.include? "q"
    break
  end
  item =~ %r{[\d\+\*\/\!\-]} ? expression << item : puts("Incorrectly input!")
end