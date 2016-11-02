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
  map(a, b)
end

def map(a, b)
  a.map! do |el|
    break if b <= 0
    if el == "1"
      b -= 1
      "0"
    else el
    end
  end
  a.join.reverse.to_i(2)
end

puts "Enter expression in polish notation using space between symbols"
while (input = gets)
  begin
    expression_array = input.split
    operands = []
    expression_array.each do |element|
      if !element.match(/\A[+-]?\d+(\.\d+)?([eE]\d+)?\Z/).nil?
        operands.push(element)
      elsif element == "+"
        operands.push(sum(operands.pop(2)))
      elsif element == "-"
        operands.push(diff(operands.pop(2)))
      elsif element == "/"
        operands.push(div(operands.pop(2)))
      elsif element == "*"
        operands.push(mult(operands.pop(2)))
      elsif element == "!"
        operands.push(bit(operands.pop(2)))
      end
    end
    puts "Answer: #{operands}"
  end
end
