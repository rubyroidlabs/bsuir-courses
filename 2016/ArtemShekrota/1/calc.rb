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
  
    def sel(s, opers)
      if s == "+"
        opers.push(sum(opers.pop(2)))
      elsif s == "*"
        opers.push(mult(opers.pop(2)))
      elsif s == "-"
        opers.push(diff(opers.pop(2)))
      elsif s == "/"
        opers.push(div(opers.pop(2)))
      elsif s == "!"
        opers.push(bit(opers.pop(2)))
      end
    end

  def calculate(expression)
    expression_array = expression.split

    puts "Wrong data!" if expression_array.length < 2
    operands = []
    
    expression_array.each do |i|
      if !i.match(/[0-9]/).nil?
        operands.push(i)
      else sel(i, operands)
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
