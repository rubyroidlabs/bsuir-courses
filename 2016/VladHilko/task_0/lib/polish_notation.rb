# Reverse Polish notation class
class PolishNotation
  def calculate(first, second, operation)
    first = first.to_i
    second = second.to_i

    case operation
    when '+'
      first + second
    when '-'
      first - second
    when '/'
      first / second
    when '*'
      first * second
    when '!'
      binary_operator(first, second)
    else
      raise 'wrong value!'
    end
  end

  def binary_operator(first, second)
    #  (93,3) ( 01011101 ) -> (01010000 ) 80
    count = 1
    first.to_s(2).chars.reverse.map do |a|
      if count <= second && a == '1'
        count += 1
        '0'
      else
        a
      end
    end.reverse.join.to_i(2)
  end
end
