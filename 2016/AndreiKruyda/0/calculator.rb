def binar_!(value, number)
  mask = 1
  p = 0
  value.to_s(2).length.times do |i|
    next if p == number
    if (value & (mask << i)).nonzero?
      value &= ~(mask << i)
      p += 1
    end
  end
  value
end

symbols = gets
symbols = symbols.split
values = []
operands = []
symbols.each do |x|
  case x
  when /\d/
    values.push(x.to_i)
  when "-", "+", "/", "*"
    operands = values.pop(2)
    values.push(operands[0].send(x, operands[1]))
  when "!"
    operands = values.pop(2)
    values.push(binar_!(operands[0], operands[1]))
  else
    puts "Error: Invalid symbol !"
    exit(0)
  end
end
puts values
