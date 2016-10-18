def convert_pol(symbols)
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
  values
end

def binar_!(value, number)
  mask = 1
  p = 0
  value.to_s(2).length.times do
    next if p == number
    if (value & mask).nonzero?
      value &= ~mask
      p += 1
    end
    mask <<= 1
  end
  value
end

symbols = gets
puts convert_pol(symbols)
