#:nodoc:
class Calculator
  def count(expression)
    a = []
    expression.each do |expr|
      case expr
      when  %r{\d+}
        a[a.size] = expr.to_i
      when  %r{\+|\*|\/|\-|\!|}
        count2(expr, a)
      end
    end
    a[0]
  end

  def count2(operator, a)
    case operator
    when  %r{\+|\-}
      simple_count(operator, a)
    when  %r{\*|\/}
      hard_count(operator, a)
    when "!"
      zeroing(a)
    end
  end

  def simple_count(operator, a)
    case operator
    when "+"
      sum(a)
    when "-"
      difference(a)
    end
  end

  def hard_count(operator, a)
    case operator
    when "*"
      composition(a)
    when "/"
      quotient(a)
    end
  end

  def sum(a)
    a[a.size] = (a[a.size - 1] + a[a.size - 2])
    delete(a)
  end

  def difference(a)
    a[a.size] = (a[a.size - 2] - a[a.size - 1])
    delete(a)
  end

  def composition(a)
    a[a.size] = (a[a.size - 1] * a[a.size - 2])
    delete(a)
  end

  def quotient(a)
    a[a.size] = (a[a.size - 2] / a[a.size - 1])
    delete(a)
  end

  def zeroing(a)
    reset = a[a.size - 2].to_s(2).reverse
    a[a.size - 1].times { reset[reset.index("1")] = "0" }
    a[a.size] = reset.reverse.to_i(2)
    delete(a)
  end

  def delete(a)
    a.delete_at(-3)
    a.delete_at(-2)
  end
end
