stack = []
number = 0

loop do
	a = gets.chomp
	if a =~ /\d/
		stack.push(a.to_i)
		number+=1
	elsif (%w[* - + / ].include?(a)) && stack.size != 1
		x1 = (stack.pop).to_i
		x2 = (stack.pop).to_i
		number-=1
		case a
		when '+'
			result = x2 + x1
		when '-'
			result = x2 - x1
		when '*'
			result = x2 * x1s
		when '/'
			result = x2 / x1
		end
		stack.push(result)
		break if number == 1
	else 
		puts "Error !!!!"
	end
end
puts "Result: " + stack.pop.to_s
