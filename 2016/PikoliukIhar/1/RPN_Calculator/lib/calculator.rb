class Calculator

  def count(expression)
    arguments = []

    expression.each do |expr|
      case expr
      when /\d+/
        arguments[arguments.size] = expr.to_i
      when "+"
        sum(arguments)
      when "*"
        composition(arguments)
      when "/"
        quotient(arguments)
      when "-"
        difference(arguments)
      when "!"
        zeroing(arguments)
      end
    end
    return arguments[0]
  end

  def sum(a)
      a[a.size] = (a[a.size-1] + a[a.size-2])
      return delete(a)
    end

  def difference(a)
    a[a.size] = (a[a.size-2] - a[a.size-1])
    return delete(a)
  end

  def composition(a)
    a[a.size] = (a[a.size-1] * a[a.size-2])
    return delete(a)
  end

  def quotient(a)
    a[a.size] = (a[a.size-2] / a[a.size-1])
    delete(a)
  end

  def zeroing(a)
    reset=a[a.size-2].to_s(2).reverse
    number_of_reset=a[a.size-1].times {
      reset[reset.index("1")] = "0"
    }
    a[a.size] = reset.reverse.to_i(2)
    delete(a)
  end

  def delete(a)
    a.delete_at(-3)
    a.delete_at(-2)
  end
end
