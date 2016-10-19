#!/usr/bin/env ruby
# class RPNCalculator
class RPNCalculator
  def special_func(first, second)
    tmp_arr = ("0" + first.to_s(2)).split(//)
    index = (second * - 1) - 1
    (index..0).each { |i| tmp_arr[i] = "0" }
    result = "0" + tmp_arr.join("")
    result.to_i(2)
  end

  def evaluate(rpn)
    array = rpn.split(" ").inject([]) do |stack, i|
      if i =~ /\d+/
        stack << i.to_i
      else
        case_func(stack, i)
      end
    end
    p array.pop
  end
 
  def case_func(volume, key)
    b = volume.pop(2)
    case key
    when "+" then volume << b[0] + b[1]
    when "-" then volume << b[0] - b[1]
    when "*" then volume << b[0] * b[1]
    when "/" then volume << b[0] / b[1]
    when "!" then volume << special_func(b[0], b[1])
    else p 'Smthing is wrong. Check input'
    end
  end
end
