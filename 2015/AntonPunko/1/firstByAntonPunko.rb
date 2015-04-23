def first_condition(n)
	n.times { print " " }
    puts "       ________ \r"
    n.times { print " " }
    puts "      |      __\\ \r"
    n.times { print " " }
	puts "      |         \\ \r"
	n.times { print " " }
	puts "      |    ____|  \r"
	n.times { print " " }
	puts "      |_______/ \r"
	n.times { print " " }
	puts "      |       |_________\r"
	n.times { print " " }
	puts "     _|_______|_______|_|\r"
	n.times { print " " }
	puts "    |________|_|   \r"
	n.times { print " " }
	puts "      |       |\r"
	n.times { print " " }
	puts "      |_______|\r"
	n.times { print " " }
	puts " _____|  __   |\r"
	n.times { print " " }
	puts "|   ____|  |  |\r"
	n.times { print " " } 
	puts "|  |       |  |__\r"
	n.times { print " " }
	puts "|__|       |_____|\r" 
end

def second_condition(n)
	n.times { print " " }
    puts "       ________\r"
    n.times { print " " }
    puts "      |      __\\\r"
    n.times { print " " }
	puts "      |         \\\r"
	n.times { print " " }
	puts "      |    ____| \r"
	n.times { print " " }
	puts "      |_______/ \r"
	n.times { print " " }
	puts "     _|       |_\r"
	n.times { print " " }
	puts "    |_|_______|_|_______\r"
	n.times { print " " }
	puts "      |_______|_______|_|  \r"
	n.times { print " " }
	puts "      |       |\r"
	n.times { print " " }
	puts "      |_______|\r"
	n.times { print " " }
	puts " _____|  __   |\r"
	n.times { print " " }
	puts "|   ____|  |  |\r"
	n.times { print " " } 
	puts "|  |       |  |__\r"
	n.times { print " " }
	puts "|__|       |_____|\r" 
end
i = 0
27.times {
	first_condition(i*2)
	sleep(0.2)
	puts "\e[H\e[2J"
	second_condition(i*2)
	sleep(0.2)
	puts "\e[H\e[2J"
	i += 1	
}