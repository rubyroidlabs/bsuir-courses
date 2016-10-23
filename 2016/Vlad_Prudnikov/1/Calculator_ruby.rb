class Calculator_ruby

  def Lounch
    oper_arr = ["+\n", "-\n", "*\n", "/\n", "!\n"]
    stack = []
    k=0
    starting = Calculator_ruby.new
    loop do 
      local = gets
      if oper_arr.include?(local.to_s)
        case local.to_s 
          when "+\n"
            stack[-2] = stack[-2] + stack [-1]
          when "-\n" 
            stack[-2] = stack[-2] - stack [-1]
          when "*\n" 
            stack[-2] = stack[-2] * stack [-1]
          when "/\n" 
            stack[-2] = stack[-2] / stack [-1]
          when "!\n" 
            stack[-2] = starting.Binary stack[-2], stack[-1]
        end
      stack.delete_at(stack.length - 1)
      else
        stack.push(local.to_i)
      end
      puts "Stack = #{stack}"
      k += 1
      break if stack.length <= 1 && k != 1
    end
  puts "Result = #{stack[0]}"
  end

  def Binary(num, power)
    l_num = num
    counter1 = 0
    counter2 = 0
    while counter1 < power && num.positive?
      div_mod = l_num.divmod(2)
      if div_mod[1] == 1
        num = num - 2**counter2
        counter1 += 1
      end
      l_num = div_mod[0]
      counter2 += 1
    end
    return num
  end

end

start = Calculator_ruby.new
start.Lounch

