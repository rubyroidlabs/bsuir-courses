# Calculating
class Calc
  def sum(array)
    array[0].to_f + array[1].to_f
  end

  def mult(array)
    array[0].to_f * array[1].to_f
  end

  def diff(array)
    array[0].to_f - array[1].to_f
  end

  def div(array)
    array[0].to_f / array[1].to_f
  end

  def bit(array)
    a = array[0].to_i.to_s(2).reverse.split(//)
    b = array[1].to_i
    a.map! do |i|
      break if b <= 0
      if i == "1"
        b -= 1
        "0"
      end
    end
    a.join.reverse.to_i(2)
  end
  
  def calculate(expression)
    expression_array = expression.split
    operands = []

    puts "Wrong data!" if expression_array.length < 2
    
    expression_array.each do |i|
      if !i.match(/[0-9]/).nil?
        operands.push(i)
      elsif i == "+"
        operands.push(sum(operands.pop(2)))
      elsif i == "*"
        operands.push(mult(operands.pop(2)))
      elsif i == "-"
        operands.push(diff(operands.pop(2)))
      elsif i == "/"
        operands.push(div(operands.pop(2)))
      elsif i == "!"
        operands.push(bit(operands.pop(2)))
      end
    end
    puts "Answer: #{operands}"
  end
end

puts "Enter expression in polish notation using space between symbols"
while a = gets
begin
  g = Calc.new()
  g.calculate(a)
  end
end
