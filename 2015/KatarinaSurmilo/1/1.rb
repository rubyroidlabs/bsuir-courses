frames = []

filenames = Dir.entries('frames').select do |fn|
	fn != '.' and fn != '..'
end

sortedFns = filenames.sort do |fn1, fn2|
	fn1.to_i - fn2.to_i
end

sortedFns.each do |filename|
	path = "#{Dir.pwd}/frames/#{filename}"
	frame = File.readlines(path).join 
	frames.push frame
end

3.times do
	frames.each do |frame|
		puts frame
		sleep 0.2
		system('clear')
	end
end
