require 'curses'

msg1 = ["RRRRRRRRR      U         U    BBBBBBB     Y         Y",
	"R        R     U         U    B      B     Y       Y ",
	"R         R    U         U    B       B     Y     Y  ",
	"R        R     U         U    B      B       Y   Y   ",
 	"RRRRRRRRR      U         U    BBBBBBB         Y Y    ",
	"R     R        U         U    B      B         Y     ",
	"R      R        U       U     B       B        Y     ",
	"R       R        U     U      B      B         Y     ",
	"R        R        UUUUU       BBBBBBB          Y     "]

msg2 = ["           CCCCCC        +            +              ",
	"          C              +            +              ",
	"         C               +            +              ",
	"         C               +            +              ",
 	"         C          +++++++++++  +++++++++++         ",
	"         C               +            +              ",
	"         C               +            +              ",
	"          C              +            +              ",
	"           CCCCCC        +            +              "]
 
Curses.init_screen
begin
	cycles=Curses.cols+msg1[0].length
	cycles_iterator=0
	start_spaces=Curses.cols-1
	end_spaces=1
	start_edge=1
	end_edge=0

	Curses.curs_set(0)
	Curses.addstr(" "*Curses.cols*msg1.size)
	Curses.refresh
	sleep 0.04
  
	while cycles>0
		Curses.setpos(0, 0)
		cycles_iterator+=1

		if cycles>Curses.cols 				#выезжаем
  			if cycles_iterator == 25
				msg2.each { |e| Curses.addstr(" "*start_spaces+"#{e[0..end_edge]}") }
			else
				msg1.each { |e| Curses.addstr(" "*start_spaces+"#{e[0..end_edge]}") }
			end
			end_edge+=1
			start_spaces-=1
		end

		if cycles>msg1[0].length && cycles<=Curses.cols	#едем
			if cycles_iterator == 25
				msg2.each { |e| Curses.addstr(" "*start_spaces+"#{e}"+" "*end_spaces) }
			else
				msg1.each { |e| Curses.addstr(" "*start_spaces+"#{e}"+" "*end_spaces) }
			end
			start_spaces-=1
			end_spaces+=1
		end

		if cycles<=msg1[0].length			#уезжаем
			if cycles_iterator == 25
				msg2.each { |e| Curses.addstr("#{e[start_edge..msg2[0].length]}"+" "*end_spaces) }
			else
				msg1.each { |e| Curses.addstr("#{e[start_edge..msg1[0].length]}"+" "*end_spaces) }
			end
			start_edge+=1
			end_spaces+=1
		end
		
		Curses.refresh
		cycles-=1
		if cycles_iterator == 25
			cycles_iterator = 0
			sleep 0.15				#25-ый кадр и вправду какой-то незаметный, поэтому пауза подольше :)
		else
			sleep 0.04
		end
	end

ensure
  	Curses.close_screen
end
