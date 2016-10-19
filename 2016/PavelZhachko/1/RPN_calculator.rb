#!/usr/bin/env rubys

class RPN_Calculator

  def special_func(first, second)
   tmp_str = "0" + first.to_s(2)
   tmp_array = tmp_str.split(//)
   index = (second * - 1) -1
   while index < 0 do
    tmp_array[index] = "0"
    index += 1
   end
   result = "0" + tmp_array.join('')
   return result.to_i(2)
  end	
	
  def evaluate(rpn)
   a = rpn.split(' ')
    array = a.inject([]) do |array, i|
     if i =~ /\d+/
      array << i.to_i
     else
      b = array.pop(2)
      case
       when i == "+" then array << b[0] + b[1]
       when i == "-" then array << b[0] - b[1]
       when i == "*" then array << b[0] * b[1]
       when i == "/" then array << b[0] / b[1]
       when i == "!" then array << special_func(b[0], b[1])
      end
	 end
	end
	p array.pop
  end
end
