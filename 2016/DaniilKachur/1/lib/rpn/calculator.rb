module RPN
  # calculating reverse polish notation
  class Calculator
    def self.solve(rpn)
      rpn.split("\n").inject([]) do |stack, token|
        stack << (token =~ /\d+/ ? token.to_f : stack.pop(2).inject(token.to_sym))
      end.pop || 0
    end
  end
end
