require 'curses'
system("clear")
R = ["||====== ||      || |||||||| ||      ||			",
	 "||    || ||      || ||    ||   ||  ||				", 
	 "||====== ||      || |||||||      ||				", 
	 "||||     ||      || ||    ||     ||				", 
	 "||  ||   ||      || ||    ||     ||				",
	 "||    || |||||||||| ||||||||     ||				",
	]
Curses.init_screen
begin	

thr = Thread.new do 
	c = Curses.getch()
	case c
		when "q"
			exit		
	end		
end
Curses.setpos(0,0)
Curses.addstr "For exit push the butoon 'q'"
Curses.refresh()
for j in 0..20
		for i in 0..R.length-1	
		sleep 0.1
		case j
			when 0
				Curses.setpos(i+1,j)
			else 
				Curses.setpos(i+1,j-1)
		end			
		Curses.addstr " "
		Curses.refresh()
		Curses.setpos(i+1,j)
		Curses.addstr R[i]
		Curses.refresh()
		end
	end
	ensure
  Curses.close_screen
end