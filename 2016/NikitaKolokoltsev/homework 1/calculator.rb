def remove_bits(bits_to_remove, number)
	s = [number].pack("G").bytes.map{ |n| "%08b" % n } # "G" - packing as float value with double precision; "%08b" - convert string bytes to binary
				.reverse.map{ |n| # reverse needed for more understandable float number representation: sign bit - exponent - mantissa
					n.split('').reverse.map{ |i| # n.split will give us every bit of our number
						if i == "1" && bits_to_remove > 0 then
							i = "0"
							bits_to_remove -= 1
						end
						i 
					}.reverse
							.join 
				}.reverse # reverse to initial representation
					.map{ |n| ("%d" % "0b#{n}").to_i.chr }
						.join # convert back to packed string and 
							.unpack("G")[0].to_f # unpack this string
end

expression = []
until (input = gets.chomp).empty?
	expression.push(input)
end

if expression.include?("!")
	puts expression.each_with_object([]){ |e, s|
		if e =~ /[0-9]/
			s.push(e.to_f)
		elsif e == "!"
			s.push(remove_bits(s.pop, s.pop))
		else
			s.push(s.pop(2).inject(e).to_f)
		end
		s
	}
else
	puts expression.each_with_object([]) { |e, s| e =~ /[0-9]/ ? s.push(e.to_f) : s.push(s.pop(2).inject(e).to_f); s }
end
