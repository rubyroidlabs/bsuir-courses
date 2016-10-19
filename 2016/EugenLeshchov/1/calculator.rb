curr_str = '\0'
str_arr = []

while curr_str != '\n'
  curr_str = gets
  str_arr.push(curr_str.chomp)
  if (curr_str.chomp == '+') || (curr_str.chomp == '-') || (curr_str.chomp == '*') || (curr_str.chomp == '/') || (curr_str.chomp == '!')
    if (curr_str.chomp == '!')
      str_arr.pop
      ones_num = str_arr.pop.to_i
      a = temp_a = str_arr.pop.to_i

      curr_ones_num = 0
      sh_amount = 0

      while curr_ones_num != ones_num
        if (tempa % 2 == 1)
          curr_ones_num += 1
        end
        temp_a /= 2
        sh_amount += 1
      end

      str_arr.push((a >> sh_amount << sh_amount).to_s)
    else
      op = str_arr.pop
      b = str_arr.pop
      a = str_arr.pop

      str_arr.push(eval(a + op + b).to_s)
    end
  end
end

puts("#=>" + str_arr[0])
