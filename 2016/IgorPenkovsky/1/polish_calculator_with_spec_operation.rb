puts "input reverse polish notation"
first_num = gets.chomp.to_i
second_num = gets.chomp.to_i
third = gets.chomp
if third.match(/\D/)
  if third == "+"
    result = first_num + second_num
  end
  if third == "-"
    result = first_num - second_num
  end
  if third == "*"
    result = first_num * second_num
  end
  if third == "/"
    result = first_num / second_num
  end
  if third == "!"
    b = first_num.to_s(2)
    c = b.length.to_i
    d = b.length.to_i
    e = 1
    g = []
    while c != 0
      f = first_num[d - c]
      if e <= second_num
        if f == 1
          g[d - c] = first_num[~(d - c)]
          e+=1
        else
          g[d - c] = first_num[d - c]
        end
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
  end
  puts "result= " + result.to_s
  exit
end
forth = gets.chomp
if forth.match(/\D/)
  fifth = gets.chomp
  if fifth.match(/\D/)
          result = second_num + third.to_f if forth == "+" ||  result = second_num - third.to_f  if forth == "-" ||
          result=second_num * third.to_f  if forth == "*" || result = second_num / third.to_f  if forth == "/"
  end
  result=result + first_num if fifth == "+" || result=result - first_num  if fifth == "-"||
      result=result * first_num if fifth == "*" || result = result / first_num  if fifth == "/"
  end
puts "result= " + result.to_s