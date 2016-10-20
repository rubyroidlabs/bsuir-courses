def bit_operation(number, bits)
  bit_float_string = [number].pack('f').unpack('b*')[0]
  bits.to_i.times { bit_float_string.sub!('1', '0') }
  [bit_float_string].pack('b*').unpack('f')[0]
end

def operate(sign, first, second)
  sign == '!' ? bit_operation(second, first) : [second, first].inject(sign)
end

def numeric?(obj)
  obj.to_s.match(/\A[+-]?\d+(\.\d+)?([eE]\d+)?\Z/).nil? ? false : true
end

operators = ['+', '-', '*', '/', '!']

puts 'Start input'
stack = []
loop do
  input = gets.chomp
  if numeric?(input)
    stack << input.to_f
  elsif operators.include?(input)
    if stack.size < 2
      puts 'There are no operands to calculate'
      next
    end
    answer = operate(input, stack.pop, stack.pop)
    stack << answer
  elsif input == ''
    break if stack.size == 1
  else
    puts 'Incorrect input'
    next
  end
end

puts stack
