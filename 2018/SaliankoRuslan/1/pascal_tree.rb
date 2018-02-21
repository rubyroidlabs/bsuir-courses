def pascal(n, number)
	line = [number]
	for k in 0...n
		line.push (line[k].to_i * (n - k) / (k + 1))
	end 
	line
end

def format_pascal(n, number)
	col = `/usr/bin/tput cols`.chomp.to_i 
	pascal(n, number).to_s.center(col)
end

print 'Введите глубину дерева: '
n = gets.chomp.to_i
print 'Введите базовый номер: '
number = gets.chomp.to_i

for i in 0...n
	puts "#{i}: #{format_pascal(i, number)}"
end 
