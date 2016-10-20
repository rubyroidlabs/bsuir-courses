require 'colorize'
class Error

  def input_check(expression)
    null_check(expression)
    operands = 0
    expression.each do |expr|
      case expr
      when /\d+/
         operands += 1
      else
        operators_check(expr)
      end
    end
    arguments_check(expression,operands)
  end

  def null_check(expression)
    if(expression == "=")
      puts "Error. You must write expression.".red
      exit 1
    end
  end

  def operators_check(expr)
    if (expr!=/\d+/&&expr!="="&&expr!="+"&&expr!="-"&&expr!="*"&&expr!="/"&&expr!="!")
      puts "Error. Wrong expression, please use only numbers and symbols: +, *, /, -, !, =.".red
      exit 1
    end
  end

  def arguments_check(expression, operands)
    if (expression.size/2!=operands || expression.size < 3)
      puts "Error. Wrong number of arguments".red
      exit 1
    end
  end
end
