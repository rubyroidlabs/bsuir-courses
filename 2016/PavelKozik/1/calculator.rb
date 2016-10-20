def operation_with_bits(value, number_od_bits)
  bits = []
  i = 0
  new_value = 0

  while value.nonzero?
    bits.push(value % 2)
    value /= 2
  end

  while i != bits.size
    if bits[i] == 1 && number_od_bits.nonzero?
      bits[i] = 0
      number_od_bits -= 1
    end
    i += 1
  end

  bits = bits.reverse
  i = 0

  while i != bits.size
    new_value += bits[i] * (2**(bits.size - i - 1))
    i += 1
  end

  new_value
end

def split_and_count
  operands = []
  x = gets.chomp
  while x.match(/\w/) != true && (x.match(/^\d*$/) || x == "")
    operands.push(x.to_i) unless x == ''
    x = gets.chomp
  end
  while operands.size > 1
    case x
    when /\w/
      abort("Syntax error. You can use only digits and operators like / * - + and ** for ^")
    when "!"
      sum = operands.pop(2)
      operands.push(operation_with_bits(sum[0], sum[1]))

    when "+", "-", "*", "/", "**"
      sum = operands.pop(2)
      operands.push(sum[0].send(x, sum[1]))
    else
      abort("Syntax error.")
    end
    break if operands.size == 1
    x = gets.chomp
  end

  abort("Syntax error.") if operands.size > 1 || operands.size.zero?
 
  puts "#=> #{operands[0]}"
end

split_and_count
