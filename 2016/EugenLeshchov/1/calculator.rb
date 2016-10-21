NUMS = %r/[+-]?[0-9]*\.?[0-9]+/
OPS = %r/[\+\-\*\/\!]{1}/
# reverse polish natation class
class RPN
  # constructor
  def initialize
    @exp = []
    @stack = []
  end

  # put expression for following calculations
  def put_expression
    until (op = gets.chomp) == ""
      @exp.push(op)
    end
  end

  # checking accuracy of entered expression
  def check_expression
    nums_amount = 0
    ops_amount = 0
    @exp.each do |op|
      if op.match(NUMS) nums_amount += 1
      elsif op.match(OPS) ops_amount += 1
      else fail "IError"
      end
    end
    if ((nums_amount - ops_amount) != 1) || (nums_amount + ops_amount < 3)
      fail "OpsAmountError"
    end
    fail "EmptyError" if @exp.empty?
  end

  # converting operands and calculating expression
  def calculate
    until @exp.empty?
      if (op = @exp.pop).match(NUMS) then @stack.push(op)
      else
        second_operand = @stack.pop.to_f
        first_operand = @stack.pop.to_f
        apply_op(first_operand, second_operand, op)
      end
    end
  end

  # applying operation
  def apply_op(a, b, op)
    case op
        when "+", "-", "*", "/"
          @stack.push(a.send(op, b).to_s)
        when "!"
          @stack.push(make_zero(a, b))
        end
  end

  # convert ones into zeroes in binary representation of number
  def make_zero(op, ones_num)
    op = op.to_i.to_s(2).reverse

    ones_num = ones_num.to_i
    curr_num = 0
    op.each_char do
      if curr_num != ones_num
        op[op.index("1")] = "0"
        curr_num += 1
      end
    end
    op.reverse.to_i(2).to_f
  end

  # put result into console output
  def gets_result
    puts @stack.pop
  end

  # main
  def main
    put_expression

    check_expression

    @exp.reverse!

    calculate

    gets_result
  rescue => e
    puts e.message
    exit
  end
end

t = RPN.new
t.main
