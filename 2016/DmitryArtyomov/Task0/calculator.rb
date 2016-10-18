#!/usr/bin/env ruby

def kill_bits_iterate(number_bits, n)
  # fraction for float is 23 bits, iterate through them to find
  # the bits which are 1 and change them to 0
  (0...23).each do |i|
    next if number_bits[i] == '0'
    number_bits[i] = '0'
    n -= 1
    return [number_bits.join].pack('b*').unpack('f')[0] if n.zero?
  end
  # if we are here and haven't returned yet, it means there is not
  # enough '1' bits in fraction, so the result is 0
  0.0
end

# bits are "killed" only in fraction
def kill_bits(number, n)
  # if 'n' is not a finite number, no need to "kill" bits, because
  # all of them will be killed
  return 0 unless n.finite?
  n = n.to_i
  # if bits are less or equal than zero, we can return the incoming
  # number, it won't change
  return number if n <= 0
  # pack the number to float and unpack to binary string,
  # the bit order is from lowest to highest
  number_bits = [number].pack('f').unpack('b*')[0].split('')
  kill_bits_iterate(number_bits, n)
end

# cast operand from float to string for eval. If it
# is not finite, pass it as float constant in string
def check_finity(op)
  op.finite? ? op.to_s : 'Float::' + op.to_s.upcase
end

# process operation represented by 1 char. Operands are in stack
def operation(symbol, stack)
  # if not enough operands in stack, return nil
  return nil if stack.count < 2
  op2 = stack.pop
  op1 = stack.pop
  return kill_bits(op1, op2) if symbol == '!'
  # evaluate expression
  eval(check_finity(op1) + symbol + check_finity(op2))
end

# process user IO
def user_io(input, stack)
  case input
  when '+', '-', '*', '/', '!'
    res = operation(input, stack)
    # if after an operation there is only 1 element in stack, it
    # means that it's the end of expression and need to print the answer
    no_ops = "Not enough operands on stack (#{stack.count}), ignore".freeze
    res.nil? ? (puts no_ops) : (stack.push(res); return 1 if stack.count == 1)
  else
    # check, whether input is a number. If it is, push it to stack as a float.
    # Otherwise throw error message
    wr_syn = 'Wrong syntax, ignore'.freeze
    input =~ /^-?\d+(\.?\d+)?$/ ? stack.push(input.to_f) : (puts wr_syn)
  end
  0
end

def main
  stack = []
  while user_io(gets.strip, stack).zero? do end
  puts '#=> ' + stack.pop.to_s + "\n"
end

main
