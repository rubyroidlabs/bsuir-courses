# Reverse Polish notation class
class PolishNotation
  def perform_action(symbol, evaluation)
    case symbol
    when /\d/
      evaluation.push(symbol.to_i)
    when "-", "/", "*", "+"
      operands = evaluation.pop(2)
      evaluation.push(operands[0].send(symbol, operands[1]))
    when '!'
      operands = evaluation.pop(2)
      zero_bits(operands[0], operands[1])
    end
  end

  def evaluate(expression)
    evaluation = []
    expression.each do |symbol|
      perform_action(symbol, evaluation)
    end
    puts evaluation
  end

  def zero_bits(number, number_of_bits)
    number = number.to_s(2).reverse
    number.length.times do |i|
      break if number_of_bits <= 0
      if number[i] == '1'
        number[i] = '0'
        number_of_bits -= 1
      end
    end
    p number.reverse.to_i(2)
  end

  def right_input?(expression)
    numbers = 0
    operations = 0
    expression.each { |symbol| numbers += 1 if symbol =~ /\d/ }
    expression.each { |symbol| operations += 1 if symbol =~ %r{/[\*\+\/\-\!]/} }
    (numbers - operations) == 1 && expression.size > 1
  end
end
