relax0 = []
relax0[0] = ['     _________________________']
relax0[1] = ['       |    |    |    |    \\']
relax0[2] = ['       |    |    |    |     \\']
relax0[3] = ['       |    |    |    |      \\']
relax0[4] = ['       |    |    |    |       \\']
relax0[5] = ['      _|_  _|_  _|_  _|_      _\\_']
relax0[6] = ['     /   \\/   \\/   \\/   \\    /   \\']
relax0[7] = ['     \\___/\\___/\\___/\\___/    \\___/']
relax1 = []
relax1[0] = ['     _________________________']
relax1[1] = ['       /    |    |    |    |']
relax1[2] = ['      /     |    |    |    |'] 
relax1[3] = ['     /      |    |    |    |']
relax1[4] = ['    /       |    |    |    |']
relax1[5] = ['  _/_      _|_  _|_  _|_  _|_']
relax1[6] = [' /   \\    /   \\/   \\/   \\/   \\']
relax1[7] = [' \\___/    \\___/\\___/\\___/\\___/']
system 'clear'
loop do
	relax0.each do |i|
		puts i
	end
	sleep 0.3
	system 'clear'
	relax1.each do |i|
		puts i
	end
	sleep 0.3
	system 'clear'
end

