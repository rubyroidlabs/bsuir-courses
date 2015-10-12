
clear_const = "\e[H\e[2J"
lines = File.readlines("anim.txt")

puts clear_const
for a in 0..1
	for i in 0..19	# from 1st to 20th frame
		for j in 0..9	# lines
			puts lines[i*10 + j]
		end
		sleep(0.17)
		puts clear_const
	end
end