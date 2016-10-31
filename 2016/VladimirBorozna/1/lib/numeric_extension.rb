# Adds a binary operator '!' to Numeric
class Numeric
  def !(other)
    return self if other <= 0
    to_i & (-1 << leftmost_bit_index(to_i.to_s(2), other))
  end

  private

  def leftmost_bit_index(binary, number_bits)
    number_bits = number_bits.to_i
    i = binary.length - 1
    while number_bits.positive? && i >= 0
      number_bits -= 1 if binary[i] == "1"
      i -= 1
    end
    binary.length - i - 1
  end
end
