# RPN calculator
class RpnCalc
  attr_reader :operators

  def evaluate(string)
    stack = []
    string.split(" ").each do |token|
      if operand? token then stack.push token
      elsif operator? token
        y = stack.pop
        x = stack.pop
        stack.push apply_operator(x, y, token)
      end
    end
    p stack
  end

  private

  def operand?(string)
    string.match(/\d/)
  end

  def operator?(string)
    @operators.key? string
  end

  def apply_operator(num1, num2, operator)
    @operators[operator][:action].call(num1.to_i, num2.to_i)
  end

  def initialize
    @operators = { "+" => { action: proc { |x, y| x + y } }, "-" => { action: proc { |x, y| x - y } }, "*" => { action: proc { |x, y| x * y } }, "/" => { action: proc { |x, y| x / y } } }
  end

  loop do
    p "Please, input your postfix expression (use spaces):"
    str = gets.chomp
    RpnCalc.new.evaluate(str)
  end
end
