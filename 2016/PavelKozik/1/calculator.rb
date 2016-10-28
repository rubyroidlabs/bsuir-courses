# Partial RPolishCalculator
class RPolishCalculator
  def initialize
    @operands = []
  end

  def operation_with_bits(value, num_of_zeros)
    binary_str = value.to_s(2).reverse
    binary_str.each_char do |bit|
      if bit == "1"
        binary_str[bit] = "0"
        num_of_zeros -= 1
      end
      break if num_of_zeros < 1
    end
    binary_str.reverse.to_i(2)
  end

  def split_and_count
    until (symbol = gets.chomp).nil?
      if is_number?(symbol)
        add_as_operand(symbol)
      elsif @operands.size >= 2 && is_operation?(symbol)
        perform_operation(symbol)
        break unless @operands.size >= 2
      else
        puts("Invalid input. There should be more operands to perfom a calculation")
      end
    end
  end

  def show_result
    puts "$ #{@operands[0]}"
  end

  private

  def operation?(sign)
    sign =~ %r{[+\-*/!]}
  end

  def number?(symbol)
    symbol =~ /^[-+]?[0-9]+$/
  end

  def add_as_operand(operand)
    @operands.push(operand.to_i)
  end

  def perform_operation(sign)
    sum = @operands.pop(2)
    if sign == "!"
      @operands. push(operation_with_bits(sum[0], sum[1]))
    else
      @operands. push(send_operation(sum[0], sum[1], sign))
    end
  end

  def send_operation(first, second, operation)
    first.send(operation, second)
  end
end
