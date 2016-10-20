#!/usr/bin/env ruby
# class RPNCalculator
class RPNCalculator
  def special_func(first, second, key)
    if key == "!"
      tmp_arr = ("0" + first.to_s(2)).split(//)
      index = second * -1
      ((index - 1)..0).each do |i|
        tmp_arr[i] = "0"
      end
      ("0" + tmp_arr.join("")).to_i(2)
    else
      first.send(key, second)
    end
  end

  def case_func(volume, key)
    b = volume.pop(2)
    if !b.empty?
      special_func(b[0], b[1], key)
    else
      "Smthing is wrong. Check input"
    end
  end

  def evaluate(rpn)
    array = rpn.split(" ").inject([]) do |stack, i|
      stack <<
        if i =~ /\d+/
          i.to_i
        else
          case_func(stack, i)
        end
    end
    p array.pop
  end
end
