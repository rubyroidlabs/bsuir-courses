# Reverse Polish notation class
class PolishNotation
  def evaluate(expression)
    operands = []
    evaluation = []
    expression.each do |symbol|
      case symbol
      when /\d/
        evaluation.push(symbol.to_i)
      when "-", "/", "*", "+"
        operands = evaluation.pop(2)
        evaluation.push(operands[0].send(symbol, operands[1]))
      when "!"
        operands = evaluation.pop(2)
        zero_bits(operands[0], operands[1])
      end
    end
    puts evaluation
  end

  def zero_bits(number, number_of_bits)
    i = 0
    number = number.to_s(2).reverse
    number.length.times do
      break if number_of_bits <= 0
      number[i] = "0", number_of_bits -= 1 if number[i] == "1"
      i += 1
    end
    p number.reverse.to_i(2)
  end

  def right_input(expression)
    numbers = 0
    operations = 0
    expression.each do |symbol|
      case symbol
      when /\d/
        numbers += 1
      when "-", "/", "*", "+", "!"
        operations += 1
      else
        fail "Expression is not valid"
      end
    end
    (numbers - operations) == 1 && expression.size > 1
  end
end
