NUM_REGEX = /[-+]?[0-9]*\.?[0-9]+(?:[eE][-+]?[0-9]+)*/
SIGN_REGEX = %r{[\+\-\*\/\!]{1}}

def main
  stack = validate_str gets
  result = rpn stack
  result.to_i if result == result.to_i
  return "=> " + result.to_s
rescue NoMethodError
  puts "Error: Incorrect RPN."
  exit
end

def validate_str(str)
  elements = str.split.map! do |element|
    if element.match(NUM_REGEX)
      element.to_f
    elsif element.match(SIGN_REGEX)
      element
    else
      fail "Input error."
    end
  end.reverse!
  elements
end

def rpn(source)
  stack = []
  until source.empty?
    if (el = source.pop).is_a? Float then stack.push el
    else
      op1 = stack.pop
      op2 = stack.pop
      stack.push arithmetic_action(op1, op2, el)
    end
  end
  fail "Error: Incorrect RPN." if stack.length != 1
  stack[0]
end

def arithmetic_action(op1, op2, sign)
  case sign
  when "+" then return op1 + op2
  when "-" then return op2 - op1
  when "*" then return op1 * op2
  when "/" then return op2 / op1
  when "!" then return zeroing(op2, op1)
  end
end

def zeroing(number, q)
  s = [number].pack("f").unpack("b*")[0]
  q.to_i.times { s.sub!("1", "0") }
  [s].pack("b*").unpack("f")[0]
end

puts main
