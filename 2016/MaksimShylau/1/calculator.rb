def nul_bin(dec, count) # ! operation (changes '1' on '0')
  ind = -1
  i = 0
  while i < count && !dec[ind].nil?
    if dec[ind] == "1"
      i += 1
      dec[ind] = "0"
    end
    ind -= 1
  end
  dec.to_s
end

def oper(symbol, a, b)
  case symbol
  when "+" then a + b
  when "-" then a - b
  when "*" then a * b
  when "/" then a / b
  when "!" then nul_bin(a.to_s(2), b).to_i(2)
  end
end
a = []
i = -1
loop do
  i += 1
  a[i] = gets.chomp
  break if a[i] == "+" || a[i] == "-" || a[i] == "*" || a[i] == "/" || a[i] == "!"
end
j = 0
res = oper(a[i], a[i - 2].to_i, a[i - 1].to_i)
ind = i
1.upto(a.size - 3) do
  j += 1
  a[i + j] = gets.chomp
  res = oper(a[i + j], a[ind - 3].to_i, res)
  ind -= 1
end
puts "#=> " + res.to_s
