a = ""
b = ""
c = '|'*30
d = ' '*15
b1 = "......................,------,    "
b2 = "......................=l     l    "
b3 = "..,---,................=l     l   "
b4 = "..|.C~ l................=l     l  "
b5 = "..|....... `------------ '------'-----------,    "
b6 = "  '.... LI,-,LI. LI. LI . LI .. LI . LI ,-,LI `- "
b7 = "  l _/,______|_|________,------,_______|_|______)"
b8 = "......................../       / "
b9 = "......................=/       /  "
b10 =".....................=/       /   "
b11 ="....................=/       /    "
b12 ="..................../______,'     "
81.times do |i| 
puts "\e[H\e[2J"
puts ((' '*114+c)*2)
if i<66 
puts a+b1+d+' '*(65-i)+c
puts a+b2+d+' '*(65-i)+c
puts a+b3+d+' '*(65-i)+c
puts a+b4+d+' '*(65-i)+c
puts a+b5+' '*(65-i)+c
puts b+b6+' '*(65-i)+c
puts b+b7+' '*(65-i)+c
puts a+b8+d+' '*(65-i)+c
puts a+b9+d+' '*(65-i)+c
puts a+b10+d+' '*(65-i)+c
puts a+b11+d+' '*(65-i)+c
puts a+b12+d+' '*(65-i)+c
else
d = ' '*(80 - i)
b5 = b5.chop
b6 = b6.chop
b7 = b7.chop
puts a+b1+d+c
puts a+b2+d+c
puts a+b3+d+c
puts a+b4+d+c
puts a+b5+c
puts b+b6+c
puts b+b7+c
puts a+b8+d+c
puts a+b9+d+c
puts a+b10+d+c
puts a+b11+d+c
puts a+b12+d+c
end
if i<15
	a='.'+a 
	elsif i<30
		if i%2==0
			a = '.' + a 
		else
			a = ' ' + a
		end
	else
		if i%3==0
			a = '.' + a 
		else
			a = ' ' + a
		end
end
b+=' '
puts ((' '*114+c)*25)
sleep(0.1)
system "clear"
system 'cls'
puts "\e[H\e[2J"
end
