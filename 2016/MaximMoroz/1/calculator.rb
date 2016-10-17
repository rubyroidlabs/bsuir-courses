class RPN

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
        stack.push (prelast / last).round(2)
      when "-"
        last = stack.pop
        prelast = stack.pop
        stack.push(prelast - last)
      when "!"
        last = stack.pop
        prelast = stack.pop
        stack.push(prelast.to_s(2).slice(0...-last).concat("0" * last).to_i(2))
      end
    end
    return stack[0]
  end

  def countable?(args)
    operands = 0
    operators = 0

    args.each do |f|
      case f
      when /\d+/
        operands += 1
      when /\+|\*|\+|\/|\-|\!/
        operators += 1
      else
        raise 'Syntax error'
      end
    end
    (operands - operators) == 1 && args.count > 1 ? true : false
  end

end



t = RPN.new()
arguments = []

loop do
  arguments << gets.chomp.to_s
  puts t.count(arguments).to_s if t.countable?(arguments)
end
