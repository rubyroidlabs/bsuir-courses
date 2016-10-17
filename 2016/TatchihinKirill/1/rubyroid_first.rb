def special_text_and_extra_parameter
  puts "Please, input one more operand for you RPN expression"
  temp_parameter = gets.chomp.to_f
end
def special_operation(number, count_of_changes)
	result = number.to_s(2)
	result = result.reverse
	count = count_of_changes
	temp = 0
	string_counter = 0
	result.each_char do |i|
	  if ((i == '1') && (temp < count))
	  	i = '0'
	  	result[string_counter] = i
	  	temp += 1
	  	string_counter += 1
	  else
	  	result[string_counter] = i
	  	string_counter += 1
	  end
	end
	result = result.reverse
	integer_res = Integer("0b" + result)
	return integer_res
end
def main
	rpn_form = []
	operands_count = 0
	operators_count = 0
	puts "input element of your expression. To stop input '.'"
	temp = gets.chomp
	rpn_form.push(temp)
	case temp
	when /\d/
		operands_count += 1
	else
		puts 'Please, input an operand'
	end
	while ((operands_count - operators_count != 1) || (operands_count == 1))
		temp = gets.chomp
		rpn_form.push(temp)
		case temp
		when /\d/
			operands_count += 1
		when "-", "/", "*", "+", "!"
			operators_count += 1
		end
	end
	result = []
	rpn_form.each do |element|
		case element
		when /\d/
			result.push(element.to_f)
		when "-", "/", "*", "+"
			if result.size < 2
				result.push(special_text_and_extra_parameter)
			end
			first_operand = result.pop
			second_operand = result.pop
			result.push(first_operand.send(element, second_operand))
		when "!"
			if result.size < 2
				result.push(special_text_and_extra_parameter)
			end
			count_of_changes = result.pop.to_f
			number_for_changing = result.pop.to_i
			result.push(special_operation(number_for_changing, count_of_changes))
		end
	end
	puts result
  result
end
main
