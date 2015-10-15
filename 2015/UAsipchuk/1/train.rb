# train, or, in reality, small ship
s = [
"        @@#           ",
"       @@@#           ",
"      @@@@#           ",
"     @@@@@#           ",
"      @@@@#           ",
"       @@@#           ",
"        @@#           ",
"####      #     ####  ",
"####################  "
]
# temp vatiable for changing strings
c = ""

system("clear")
loop do
	# put and change a bit	
	9.times do |j|
		puts s[j]
		c = s[j][0]
		s[j][0]=''
		s[j] = s[j] + c		
	end
	sleep(0.3)
	system("clear")
end



