#!/usr/bin/env ruby

# bits are "killed" only in fraction. If there is not enough bits,
# the result is zero
def kill_bits(number, bits)
  return number if bits <= 0
  number_bits = [number].pack('f').unpack('b*')[0].split('')
  # fraction for float (23 bits), the bit order is reversed
  for i in 0...23
    next if number_bits[i] == '0'
    number_bits[i] = '0'
    bits -= 1
    return [number_bits.join].pack('b*').unpack('f')[0] if bits.zero?
  end
  0
end

def operation(symbol, stack)
  if stack.count < 2
    puts 'Not enough operands on stack, ignore'
    return nil
  end
  operand2 = stack.pop
  operand1 = stack.pop
  return kill_bits(operand1, operand2.to_i) if symbol == '!'
  eval(operand1.to_s + symbol + operand2.to_s)
end

stack = []
loop do
  input = gets.strip
  case input
  when '+', '-', '*', '/', '!'
    result = operation(input, stack)
      stack.push(result) if result != nil
    break if stack.count == 1
  else
    # matches to any number
    if input =~ /^-?\d+(\.?\d+)*$/
      stack.push(input.to_f)
    else
      puts 'Wrong syntax, ignore'
    end
  end
end
puts '#=> ' + stack.pop.to_s + "\n"
