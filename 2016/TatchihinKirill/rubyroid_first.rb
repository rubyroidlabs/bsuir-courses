def special_text_and_extra_parameter
    puts "Please, input one more operand for you RPN expression"
    temp_parameter = gets.chomp.to_f
end
def push_to_rpn_form(rpn_form, temp )
  rpn_form.push(temp)
end
def make_rpn_input(operands_count = 0, operators_count = 0, rpn_form = [])
  while ((operands_count - operators_count != 1) || (operands_count == 1))
    temp = gets.chomp
    push_to_rpn_form(rpn_form, temp)
    case temp
    when /\d/
      operands_count += 1
    when "-", "/", "*", "+", "!"
      operators_count += 1
    end
  end
  rpn_form
end
def push_performed_bit_changing(result)
  count_of_changes = result.pop.to_f
  number_for_changing = result.pop.to_i
  result.push(special_operation(number_for_changing, count_of_changes))
end
def perform_bit_changing(result)
  if result.size < 2
    result.push(special_text_and_extra_parameter)
  end
  push_performed_bit_changing(result)
end
def calculate_operations(result, element)
  first_operand = result.pop
  second_operand = result.pop
  result.push(first_operand.send(element, second_operand))
end
def special_operation(number, count_of_changes)
  result = number.to_s(2).reverse
  temp = 0
  string_counter = 0
  result.each_char do |i|
    if ((i == '1') && (temp < count_of_changes))
      result[string_counter] = '0'
      temp += 1
      string_counter += 1
    else
      result[string_counter] = i
          string_counter += 1
    end
  end
  result = result.reverse
  integer_res = Integer("0b" + result)
end
def main
  rpn_form = make_rpn_input
  result = []
  rpn_form.each do |element|
    case element
    when /\d/
      result.push(element.to_f)
    when "-", "/", "*", "+"
      if result.size < 2
        result.push(special_text_and_extra_parameter)
      end
      calculate_operations(result, element)
    when "!"
      perform_bit_changing(result)
    end
  end
  result
end
puts main
