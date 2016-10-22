oper_arr = ["+\n","-\n","!\n","*\n","/\n"]
stack = []
k=0
loop do 
  local = gets
  if oper_arr.include?(local.to_s)
    case local.to_s 
      when "+\n" 
        stack[stack.length-2] = stack[stack.length-2] + stack [stack.length-1]
      when "-\n" 
        stack[stack.length-2] = stack[stack.length-2] - stack [stack.length-1]
      when "*\n" 
        stack[stack.length-2] = stack[stack.length-2] * stack [stack.length-1]
      when "/\n" 
        stack[stack.length-2] = (stack[stack.length-2] / stack [stack.length-1]).to_c
      when "!\n" 
        l_num = stack[stack.length-2]
        power = stack [stack.length-1]
        counter1 = 0
        counter2 = 0
        while counter1<power&&stack[stack.length-2]>0
          div_mod = l_num.divmod(2)
          if div_mod[1] == 1
            stack[stack.length-2] = stack[stack.length-2] - 2**counter2
            counter1 +=1
          end
          l_num = div_mod[0]
          counter2 +=1
	end
      end
  stack.delete_at(stack.length-1)
  else
    stack.push(local.to_i)
  end
  puts "Stack = #{stack}"
  k+=1
  break if (stack.length<=1&&k!=1)
end
puts "Result = #{stack[0]}"
