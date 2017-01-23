require 'pry'
require './new_operator'

# adding ! operator
class Numeric
  include NewOperator
end

# calculating reverse polish notation
class RPNCalculator
  def self.calculate(rpn)
    rpn.split("\n").inject([]) do |stack, token|
      stack << (token =~ /\d+/ ? token.to_f : stack.pop(2).inject(token.to_sym))
    end.pop || 0
  end
end
