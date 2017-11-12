stack = []

loop do
  input_string = gets.strip
  case input_string
  when /^-?\d(\.?\d+)?/
    puts "argument add"
    stack.push(input_string.to_f)
  when "+", "*", "/", "-"
    if stack.count < 2
      fl = true
      puts "wrong input"
    else
      temp = stack.pop
      stack.push(stack.pop.send(input_string, temp))
      break if stack.count == 1 && !fl
    end
  end
end
puts stack.pop.to_s
