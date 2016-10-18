#
class RpnCalc

  attr_reader :operators

  public

  def initialize
    @operators = {
      "+" => {
        action: Proc.new{|x,y| x+y}},
      "-" => {
        action: Proc.new{|x,y| x-y}},
      "*" => {
        action: Proc.new{|x,y| x*y}},
      "/" => {
        action: Proc.new{|x,y| x/y}},
    }
  end

  
  
  def evaluate(string)
    stack = []
    string.split(" ").each do |token|
      if operand? token then
        stack.push token
      elsif operator? token then
        y = stack.pop
        x = stack.pop
        stack.push applyOperator(x, y, token)
      end
    end
    stack.pop
  end

  private 

  def operand?(string)
    0 == (string =~ /^\d+$/)
  end


  def operator?(string)
    @operators.has_key? string
  end

  def applyOperator(num1, num2, operator)
    @operators[operator][:action].call(num1.to_i, num2.to_i)
  end

end

p RpnCalc.new.evaluate("8 8 2  / +")
# => 12