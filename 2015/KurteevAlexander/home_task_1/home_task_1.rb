require 'curses'
Dir["./constants/*.rb"].each {|file| require file }
Dir["./methods/*.rb"].each {|file| require file }
Curses.init_screen
mxsize = max_s	ize_engine
engine = [].push(ENGINE_FIRST, ENGINE_SECOND, ENGINE_THIRD, ENGINE_SECOND)
begin
	Curses.clear
	0.upto(COLS+mxsize) do |i|
		i.upto(COLS+mxsize) do |g|
 			0.upto(ENGINE_HEIGTH) do |j|
 				if COLS > i    
 					Curses.setpos(j+((LINES/2)-8),COLS-i)
	 				Curses.addstr(engine[i%4][j][0..i].to_s)
		    else
		    	Curses.setpos(j+((LINES/2)-8),0)
	 				Curses.addstr(engine[i%4][j][i-COLS..engine[i%4][j].size].to_s)
	 			end
 			end 
 		end
		Curses.setpos(LINES,0)
		sleep 0.01
 		Curses.refresh
 		Curses.clear
	end
ensure 
  Curses.close_screen
end
