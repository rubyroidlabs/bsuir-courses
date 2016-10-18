def bin (number) # From 10 to 2 base
  s = ""
  while number.to_i > 0
    s += (number.to_i%2).to_s
    number /= 2
  end
  return s.reverse
end
def nulBin(dec, count) # ! operation (changes '1' on '0')
  ind = -1
  i = 0
  while i<count && dec[ind]!=nil
    if dec[ind] == '1'
      i += 1
      dec[ind] = '0'
    end
    ind -= 1
  end
  return dec.to_s
end
def toDec(binary) # From 2 to 10 base
  sum = 0
  i = 0
  1.upto(binary.size) do
    pow = binary.size.to_i-i-1
    sum += binary[i].to_i * (2**pow)
    i += 1
  end
  return sum
end
def oper (symbol, a, b)
  case symbol
  when "+"
    return a + b
  when "-"
    return a - b
  when "/"
    return a / b
  when "*"
    return a * b
  when "!"
    return toDec(nulBin(bin(a), b))
  end
end
a = []
i = -1
loop do
  i += 1
  a[i] = gets.chomp
  break if a[i]=='+'||a[i]=='-'||a[i]=='*'||a[i]=='/'||a[i]=='!'
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
