def bin (number) #Перевод из десятичной в двоичную систему
	s=""
	while number.to_i > 0 do 
		s+=(number.to_i%2).to_s
		number/=2
	end
	return s.reverse
end

def nulBin(dec, count) #Замена 1 на нули (операция !)
	ind=-1
	i=0
	while i<count and dec[ind]!=nil 
		if dec[ind]=='1'
			i+=1
			dec[ind]='0'
		end
		ind-=1
	end
	return dec.to_s
end

def toDec(binary) #Перевод из двоичной в десятичную систему
	sum=0
	i=0
	1.upto(binary.size) do
	    sum += (binary[i].to_i)*(2**(binary.size.to_i-i-1))
	    i+=1
    end
    return sum
end

def oper (symbol, a, b) 
	case symbol
	when "+"
		return a+b
	when "-"
		return a-b
	when "/"
		return a/b
	when "*"
		return a*b
	when "!"
		return toDec(nulBin(bin(a), b))
	end
end

a = []
i = -1
loop do 
    i+=1
    a[i] = gets.chomp
    break if a[i]=='+'||a[i]=='-'||a[i]=='*'||a[i]=='/'||a[i]=='!'
end
j = 0
res = oper(a[i], a[i-2].to_i, a[i-1].to_i)
ind=i
1.upto(a.size-3) do
	j+=1
	a[i+j] = gets.chomp
	res = oper(a[i+j], a[ind-3].to_i, res)
	ind-=1
end
puts "#=> " + res.to_s