# Simple implementation of specific RPN
class RPNCalc
  def initialize
    @operands = []
  end

  def start
    until (sign = gets.chomp).nil?
      if number?(sign)
        add_operand(sign)
      elsif operands_enough? && operation?(sign)
        operate(sign)
        break unless operands_enough?
      else
        puts "invalid symbol. add some operands"
      end
    end
  end

  def show_result
    puts "#=> #{@operands[0]}"
  end

  private

  def operate(sign)
    last = @operands.pop
    pre_last = @operands.pop
    @operands << if sign == "!"
                   set_bytes_to_zero(pre_last, last)
                 else
                   calculate(pre_last, last, sign)
                 end
  end

  def add_operand(operand)
    @operands << operand.to_i
  end

  def calculate(first, second, operation)
    first.send(operation, second)
  end

  def set_bytes_to_zero(value, n_of_zeros)
    bin_str = value.to_s(2).reverse
    bin_str.each_char do |bit|
      if bit == "1"
        bin_str[bit] = "0"
        n_of_zeros -= 1
      end
      break if n_of_zeros < 1
    end
    bin_str.reverse.to_i(2)
  end

  def operands_enough?
    @operands.length >= 2
  end

  def number?(sign)
    sign =~ /^[-+]?[0-9]+$/
  end

  def operation?(sign)
    sign =~ %r{[+\-*/!]}
  end
end
