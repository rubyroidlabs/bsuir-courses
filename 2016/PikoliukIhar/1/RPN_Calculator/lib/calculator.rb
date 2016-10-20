# This is RPN Calculator
class Calculator
  def count(expr)
    arg = []

    expr.each do |e|
      case e
      when /\d+/
        arg[arg.size] = e.to_i
      when "+"
        sum(arg)
      when "*"
        composition(arg)
      when "/"
        quotient(arg)
      when "-"
        difference(arg)
      when "!"
        zeroing(arg)
      end
    end
    return arg[0]
  end

  def sum(a)
    a[a.size] = (a[a.size - 1] + a[a.size - 2])
  end

  def difference(a)
    a[a.size] = (a[a.size - 2] - a[a.size - 1])
  end

  def composition(a)
    a[a.size] = (a[a.size - 1] * a[a.size - 2])
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
