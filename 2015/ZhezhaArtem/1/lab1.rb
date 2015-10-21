system 'clear'
application1 = []
application2 = []
a = 0
application1[0] = '@@@@  @  @ @@@@ @   @   @ @ @ @'
application1[1] = '@  @  @  @ @  @  @ @   @ ***** @'
application1[2] = '@@@@  @  @ @@@@   @   @   ***   @'
application1[3] = '@ @   @  @ @  @  @      @ *** @'
application1[4] = '@  @  @@@@ @@@@ @          @'
application2 = []
application2[0] = '@@@@  @  @ @@@@ @   @   @ @ @ @'
application2[1] = '@  @  @  @ @  @  @ @   @=     =@'
application2[2] = '@@@@  @  @ @@@@   @   @===   ===@'
application2[3] = '@ @   @  @ @  @  @      @=   =@'
application2[4] = '@  @  @@@@ @@@@ @          @'
loop do
	system 'clear'
	a += 1
	if a % 2 == 0
		puts application1
		application1.map! do |space|
			unless space == ''
				if a > 240
					space.slice(0,space.length-2)
				else
					' ' + space
				end
			end
		end
	else
		puts application2
		application2.map! do |space|
			unless space == ''
				if a > 241
					space.slice(0,space.length-2)
				else
					' ' + space
				end
			end
		end
	    break if a == 281
	end
	sleep(0.03)
end
