def my_clear
	puts "\e[2J"
end

def hw
	source = File.open("oslik.txt")
	pict = source.to_a
	i = 0
	while i < 20
		j = 0
		while j < 26
			pict[j].insert(0,'_')
			j += 1
		end
		i += 1
		my_clear
		puts pict
		sleep 0.2
	end
	source.close
end

hw
