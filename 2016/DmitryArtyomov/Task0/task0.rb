#!/usr/bin/env ruby

# bits are "killed" only in fraction. If there is not enough bits, the result is zero
def kill_bits(number, bits)
  number_bits = [number].pack('f').unpack('b*')[0].split('')
  # fraction for float (23 bits), the bit order is reversed
  for i in 0...23
    if (number_bits[i] == '1')
      number_bits[i] = '0'
      bits -= 1
      return [number_bits.join].pack('b*').unpack('f')[0] if bits == 0
    end
  end
  return 0
end

def main
  stack = []
  while true
    input = gets.strip
    case (input)
    when '!'
      bits = stack.pop.to_i
      number = stack.pop
      stack.push(kill_bits(number, bits))
      break if stack.count == 1
    when '+', '-', '*', '/'
      input += stack.pop.to_s
      input = stack.pop.to_s + input
      stack.push(eval(input))
      break if stack.count == 1
    else
      # matches to any number
      if (input =~ /^-?\d+\.?\d*$/)
        stack.push(input.to_f)
      else
        puts 'Wrong syntax, ignore'
      end
    end
  end 
  puts "#=> " + stack.pop.to_s + "\n"
end

main