puts "input reverse polish notation"
first_num = gets.chomp.to_i
second_num = gets.chomp.to_i
third = gets.chomp
if third =~ /\D/
if third == "+"
  result = first_num + second_num
elsif third == "-"
  result = first_num - second_num
elsif third == "*"
  result = first_num * second_num
elsif third == "/"
  result = first_num / second_num
end
if third == "!"
  b = first_num.to_s(2)
  c = b.length.to_i
  d = b.length.to_i
  e = 1
  g = []
while c.nonzero?
  f = first_num[d - c]
if e <= second_num
if f == 1
  g[d - c] = first_num[~(d - c)]
  e += 1
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
puts result.to_s
exit
end
forth = gets.chomp
if forth =~ /\D/
  fifth = gets.chomp
if fifth =~ /\D/
if forth == "+"
  result = second_num + third.to_f
elsif forth == "-"
  result = second_num - third.to_f
elsif forth == "*"
  result=second_num * third.to_f
elsif forth == "/"
  result = second_num / third.to_f
end
end
if fifth == "+"
  result += first_num
elsif fifth == "-"
  result -= first_num
elsif fifth == "*"
  result *= first_num
elsif fifth == "/"
  result /= first_num
end
end
puts result.to_s