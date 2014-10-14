class Ascii_Star_Wars

	BASE_FRAME_RATE = 0.04
	LINES_IN_FRAME = 14

	def initialize
		cls
		load
		show
	end

	def load
		@matrix = File.read("ascii.txt").split('\n')
	end

	def show
		n = 0
		@matrix.each do |line|
			if n == 0
				@frame_rate = line.to_i
				n += 1
				@frame_rate = 2 if @frame_rate <= 0
				next
			end
			puts line
			print "\r"
			n += 1
			if n == LINES_IN_FRAME
				n = 0
				sleep BASE_FRAME_RATE*@frame_rate
				cls
			end
		end
	end

	def cls
		puts "\e[H\e[2J"
	end
end

Ascii_Star_Wars.new

# Есть маленький глюк =)
# Где-то во входном файле пропущена строка, к чему это приводит можно понять, посмотрев фильм =)