	system 'clear'
	a = []
	a[0] = '- - - - |>'
	a[1] = '- - - - -|>'
	a[2] = '- - - - -|>'
	a[3] = '- - - - |>'
	i = 0
	loop do
		system 'clear'
		i +=1
		puts a
		a.map! do |space|
			' '+space
		end
		break if i == 70
		sleep 0.03
	end
