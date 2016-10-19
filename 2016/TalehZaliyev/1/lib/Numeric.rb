class Numeric < Object # :nodoc:
  def bit_rep(num_bit)
    a = self - self.to_i
    self.to_i.to_s(2).split('').reverse.map do |x|
      (x == "1" && num_bit>0) ? ((num_bit -= 1) && (x = "0")) : x
    end.reverse.join.to_i(2) + a
  end
end
