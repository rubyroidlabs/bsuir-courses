#!/usr/bin/env ruby

class RPN_Calculator
#вынести класс в отдельный файл
	def evaluate(rpn)
		a = rpn.split(' ')
		array = a.inject([]) do |array, i|
			if i =~ /\d+/
				array << i.to_i
			else
				b = array.pop(2)
				case
					when i == "+" then array << b[0] + b[1]
					when i == "-" then array << b[0] - b[1]
					when i == "*" then array << b[0] * b[1]
					when i == "/" then array << b[0] / b[1]
					# костыль - вынести в отдельную функцию
					when i == "!" then begin
					# array << ugly_func(b[0], b[1])
						temp_str = "0" + b[0].to_s(2)
						tmp_array = temp_str.split(//)
						index = (b[1] * -1)-1
						#не забыть добавить проверку на выход индекса за пределы длинны массива
							while index < 0 do
								tmp_array[index] = "0"
								index += 1
							end
						b[0] = "0" + tmp_array.join('')
						array << b[0].to_i(2)
					# костыль	
					end
				end
			end
		end
		p array.pop
	end
end

calc = RPN_Calculator.new
p "Input rpn ex - reverse polish notation example"
a = gets.chomp
calc.evaluate(a)

def ugly_func(args)
#Horrible piece of ****
	temp_str = "0" + b[0].to_s(2)
	tmp_array = temp_str.split(//)
	index = (b[1] * -1)-1
	#не забыть добавить проверку на выход индекса за пределы длинны массива
	while index < 0 do
		tmp_array[index] = "0"
		index += 1
	end
	b[0] = "0" + tmp_array.join('')
	array << b[0].to_i(2)
end				

