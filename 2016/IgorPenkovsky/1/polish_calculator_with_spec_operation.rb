puts "input reverse polish notation"
first_num = gets.chomp.to_i
second_num = gets.chomp.to_i
third = gets.chomp
if third =~ /\D/
  case third
  when "+"
    result = first_num + second_num
  when "-"
    result = first_num - second_num
  when "*"
    result = first_num * second_num
  when "/"
    result = first_num / second_num
  when "!"
    b = first_num.to_s(2)
    c = b.length.to_i
    d = b.length.to_i
    e = 1
    g = []
    while c.nonzero?
      f = first_num[d - c]
      if e <= second_num && f == 1
        g[d - c] = first_num[~(d - c)]
        e += 1
      else
        g[d - c] = first_num[d - c]
      end
      c -= 1
    end
    j = g.reverse
    l = j.length.to_i
    i = 0
    k = ""
    while i != l
      k += j[i].to_s
      i += 1
    end
    result = k.to_i(2)
  else
    puts "Error"
  end
  puts result.to_s
  exit
end
forth = gets.chomp
if forth =~ /\D/
  fifth = gets.chomp
  if fifth =~ /\D/
    case forth
    when "+"
      result = second_num + third.to_f
    when "-"
      result = second_num - third.to_f
    when "*"
      result = second_num * third.to_f
    when "/"
      result = second_num / third.to_f
    else
      puts "Error"
    end
  end
  case fifth
  when "+"
    result += first_num
  when "-"
    result -= first_num
  when "*"
    result *= first_num
  when "/"
    result /= first_num
  else
    puts "Error"
  end
end
puts result.to_s
