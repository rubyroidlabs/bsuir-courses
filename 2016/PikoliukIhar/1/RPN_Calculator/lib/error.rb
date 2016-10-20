# This is simple eror checker for input
require 'colorize'

class Error
  def input_check(expr)
    null_check(expr)
    check(expr)
  end

  def check(expr)
    operands = 0
    expr.each do |expr|
      case expr
      when /\d+/
        operands += 1
      else
        op_check(expr)
      end
    end
    arg_check(expr, operands)
  end

  def null_check(expr)
    if (expr == "=")
      puts "Error. You must write expr.".red
      exit 1
    end
  end

  def op_check(expr)
    if (expr != /\d+/ && expr != "=" && expr != "+" && expr != "-" && expr != "*" && expr != "/" && expr != "!")
      puts "Error. Wrong expression, please use only numbers and symbols: +, *, /, -, !, =.".red
      exit 1
    end
  end

  def arg_check(expr, op)
    if (expr.size / 2 != op || expr.size < 3)
      puts "Error. Wrong number of arguments".red
      exit 1
    end
  end
end
