#!/usr/bin/ruby
def bin(var2, var1)
	j = 0
	i = 0
	tmp = var1.to_s(2).reverse
	loop do
		if tmp[i] == "1"
			tmp[i] = "0"
			j += 1
		end
		i += 1
		break if j == var2
	end
	tmp.reverse.to_i(2)
end

array = []
loop do
	variable = gets.chomp
	if variable == variable.to_i.to_s
    array.push(variable.to_i)
  else
    case variable
    when "+"
      array.push(array.pop + array.pop)
		when "-"
      array.push(array.pop - array.pop)
    when "*"
      array.push(array.pop * array.pop)
    when "/"
      array.push(array.pop / array.pop)
    when "!"
      array.push(bin(array.pop, array.pop))
    end
    break if array.length == 1
  end
end

puts "#=> #{array[0]}"
