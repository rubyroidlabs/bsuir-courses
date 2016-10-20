#This is simple eror checker for input
require 'colorize'

class Error

  def input_check(expression)
    null_check(expression)
    check(expression)
  end

  def check(expression)
    operands = 0
    expression.each do |expr|
      case expr
      when /\d+/
        operands += 1
      else
        op_check(expr)
      end
    end
    arg_check(expression, operands)
  end

  def null_check(expression)
    if(expression == "=")
      puts "Error. You must write expression.".red
      exit 1
    end
  end

  def op_check(expr)
    if(expr != /\d+/ && expr != "=" && expr != "+" && expr != "-" && expr != "*" && expr != "/" && expr != "!")
      puts "Error. Wrong expression, please use only numbers and symbols: +, *, /, -, !, =.".red
      exit 1
    end
  end

  def arg_check(expression, operands)
    if (expression.size / 2 != operands || expression.size < 3)
      puts "Error. Wrong number of arguments".red
      exit 1
    end
  end
end
