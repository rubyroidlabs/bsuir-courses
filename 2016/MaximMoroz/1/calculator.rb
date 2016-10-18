def count(arguments)
  stack = []

  arguments.each do |a|
    case a
    when /\d+/
      stack.push(a.to_i)
    when "+"
      stack.push(stack.pop + stack.pop)
    when "*"
      stack.push(stack.pop * stack.pop)
    when "/"
      last = stack.pop
      prelast = stack.pop
      stack.push((prelast / last).round(2))
    when "-"
      last = stack.pop
      prelast = stack.pop
      stack.push(prelast - last)
    when "!"
      last = stack.pop
      prelast = stack.pop
      prelast = prelast.to_s(2).chars.reverse.map do |f|
        if f == "1" && last > 0
          last -= 1
          "0"
        else
          f
        end
      end.reverse.join.to_i(2)
      stack.push(prelast)
    end
  end
  stack[0]
end

def countable?(args)
  operands = 0
  operators = 0
  args.each do |f|
    case f
    when /\d+/
      operands += 1
    when %r{\+|\*|\+|\/|\-|\!}
      operators += 1
    else
      fail "Syntax error"
    end
  end
  (operands - operators) == 1 && args.count > 1 ? true : false
end

arguments = []

loop do
  arguments << gets.chomp.to_s
  puts count(arguments).to_s if countable?(arguments)
end
