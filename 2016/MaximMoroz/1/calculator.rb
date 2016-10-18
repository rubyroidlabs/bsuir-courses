def count(arguments)
  stack = []

  arguments.each do |a|
    case a
    when /\d+/ then stack.push(a.to_i)
    when %r{\+|\*|\+|\/|\-} then operators(a, stack)
    when "!" then binary_operator(stack)
    end
  end
  stack[0]
end

def operators(a, stack)
  last = stack.pop
  prelast = stack.pop
  case a
  when "+" then stack.push(last + prelast)
  when "-" then stack.push(prelast - last)
  when "*" then stack.push(last + prelast)
  when "/" then stack.push((prelast / last).round(2))
  end
end

def binary_operator(stack)
  last = stack.pop
  prelast = stack.pop
  prelast = prelast.to_s(2).chars.reverse.map do |f|
    if f == "1" && last.positive?
      last -= 1
      "0"
    else f
    end
  end.reverse.join.to_i(2)
  stack.push(prelast)
end

def countable?(args)
  operands = 0
  operators = 0
  args.each do |f|
    case f
    when /\d+/ then operands += 1
    when %r{\+|\*|\+|\/|\-|\!} then operators += 1
    else fail "Syntax error"
    end
  end
  (operands - operators) == 1 && args.count > 1 ? true : false
end

arguments = []

loop do
  arguments << gets.chomp.to_s
  puts count(arguments).to_s if countable?(arguments)
end
