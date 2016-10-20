# The most wonderful class
class Calculator
  attr_accessor :expression, :notation, :result

  def initialize(expression)
    @expression = prepare_expression_array(expression)
    @notation = to_opn
    @result = calculate_result
  end

  def to_opn
    result = []
    stack = []

    @expression.each do |literal|
      case literal_type(literal)
      when "number" then
        result << literal
      when "operation" then
        make_operation(stack, result, literal)
      when "opening_brace" then
        stack << literal
      when "closing_brace" then
        result << stack.pop until stack.last == "("
        stack.pop
      end
    end

    result << stack.pop until stack.size.zero?

    result
  end

  def make_operation(stack, result, literal)
    if stack.size.zero? || stack_priority_less(stack, literal)
      stack << literal
    elsif priority(stack.last) >= priority(literal)
      until stack.size.zero? || priority(stack.last) < priority(literal)
        result << stack.pop
      end

      if stack.size.zero? || stack_priority_less(stack, literal)
        stack << literal
      end

    end
  end

  def calculate_result
    result = []

    @notation.each do |literal|
      case literal_type(literal)
      when "number"
        result << literal
      when "operation"
        result << operation(literal, result.pop.to_i, result.pop.to_i)
      end
    end
    @result = result.pop
  end

  def operation(operation, op1, op2)
    case operation
    when "+" then op1 + op2
    when "-" then op1 - op2
    when "/" then op1 / op2
    when "*" then op1 * op2
    when "!" then calculate_factorial(op1, op2)
    end
  end

  def calculate_factorial(operator, degree)
    char_array = operator.to_s(2).chars
    begin_bit = char_array.size > degree ? char_array.size - degree : 0

    begin_bit.upto(char_array.size) { |number| char_array[number] = 0 }
    char_array.join.to_i(2)
  end

  def stack_priority_less(stack, operation)
    stack.reverse_each do |elem|
      return true if elem == ")"

      return false unless priority(elem) < priority(operation)
    end

    true
  end

  def stack_priority_more(stack, operation)
    priority(operation) >= priority(stack.last)
  end

  def literal_type(literal)
    case literal
    when /\d+/ then "number"
    when %r{[\+\-\/\*\!]} then "operation"
    when /[\(]/ then "opening_brace"
    when /[\)]/ then "closing_brace"
    end
  end

  def priority(sign)
    case sign
    when "(" then "1"
    when "-", "+" then "2"
    when "/", "*" then "3"
    when "!" then "4"
    end
  end

  def prepare_expression_array(expression)
    expression_array = []

    correct_expression(expression).gsub(%r{[\+\-\/\*\(\)\!]|\d+\.?\d*}) { |reg| expression_array << reg }

    expression_array
  end

  def correct_expression(expression)
    expression.delete('\r')
    expression.gsub(/(?<foo>\d)\(/, '\k<foo>*(')
  end
end
