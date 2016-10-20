def reset_bits(value, number_bits)
  num_resets = 0
  n = 0
  while value.nonzero? && num_resets < number_bits
    if set_bit? value, 2**n
      num_resets += 1
      value = value ^ 2**n
    end
    n += 1
  end
  value
end

def set_bit?(value, number_marker)
  if (value & number_marker).zero?
    false
  else
    true
  end
end

flag_input_item = true
puts"Начните вводить своё выражение. "
puts"Каждый новый элемент (операнд или операцию) вводите с новой строки"
symbol = gets.chomp
quantity_numbers = 0
quantity_symbols = 0
if symbol.to_i.zero?
  puts"Выpажение не может начинаться с операции. Программа будет завершена"
  flag_input_item = false
end
quantity_numbers += 1
stack_numbers = []
stack_symbols = []
stack_numbers.push(symbol)
if flag_input_item
  loop do
    symbol = gets.chomp
    if !symbol.to_i.zero?
      quantity_numbers += 1
      stack_numbers.push(symbol.to_i)
    elsif quantity_numbers < 2
      puts"Сейчас должно следовать число."
      puts"Убедитесь,что вы знакомы с постфиксной записью числа"
      puts"Ну-ка соберитесь и попроуйте ввести снова значение"
      elsif symbol.to_s == "+" || symbol.to_s == "-" || symbol.to_s == "*" || symbol.to_s == "/" || symbol.to_s == "!"
        quantity_symbols += 1
        stack_symbols.push(symbol)
        break
    else
      puts"Вы ввели какую-то ерунду"
      puts"Попробуйте снова ввести допустимое значение"
    end
  end
  while quantity_symbols != quantity_numbers - 1
    symbol = gets.chomp
    if symbol == "+" || symbol == "-" || symbol == "*" || symbol == "/" || symbol == "!"
      stack_symbols.push(symbol)
      quantity_symbols += 1
    else
      puts"Соберитесь и начните вводить нормальные значения"
    end
  end
  until stack_symbols.empty?
    first_operand = stack_numbers.pop
    second_operand = stack_numbers.pop
    operation = stack_symbols.shift
    case operation
    when "+"
      result = first_operand.to_i + second_operand.to_i
    when "-"
      result = second_operand.to_i - first_operand.to_i
    when "*"
      result = first_operand.to_i * second_operand.to_i
    when "/"
      result = second_operand.to_i / first_operand.to_i
    when "!"
      result = reset_bits second_operand.to_i, first_operand.to_i
    end
    stack_numbers.push(result)
  end
  puts"Ответ #{result}"
end
