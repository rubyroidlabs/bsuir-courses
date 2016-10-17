# realize binaric operator "!"
module NewOperator
  def !(other)
    value, format = ((self % 1).zero? ? [self, 'c'] : [self, 'g'])
    bits = floating_point_bits_from(value, format)
    usual_value_from(clearing_bits(bits, other.to_i), format)
  end

  def floating_point_bits_from(value, format)
    [value].pack(format).bytes.map { |n| format('%08b', n) }.join
  end

  def usual_value_from(bits, format)
    bits.split('').each_slice(8).inject([]) do |result, b8|
      result << b8.join.to_i(2)
    end.pack('c*').unpack(format).pop
  end

  def clearing_bits(bits, amount)
    result = bits.reverse
    amount.times { |_| result.sub!(/1/, '0') }
    result.reverse
  end
end
