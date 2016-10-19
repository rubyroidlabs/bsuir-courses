class Numeric < Object # :nodoc:
  def bit_rep(num_bit)
    a = self - to_i
    to_i.to_s(2).split("").reverse.map do |x|
      if x == "1" && num_bit.positive?
        num_bit -= 1
        "0"
      else
        x
      end
    end.reverse.join.to_i(2) + a
  end
end
