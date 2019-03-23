require 'curses'

class Fish
  

  def initialize(row, column)
    @matrix = Array.new(row) { Array.new(column) " " }
  end

  def set_matrix(row)
    mid = row / 2
    @matrix[mid][0] = "* "
    i = 1

	#face
    (mid + 1).upto(row - 2) do |index|
	  @matrix[index][i] = "* "
	  @matrix[row -1 - index][i] = "* "
	  i +=  1
	end

	#back
	5.times do |index|
	  @matrix[1][i] = "* "
	  @matrix[row - 2][i] = "* "
	  i +=  1
	end

	#tail
	(row -2).times do |index|
	  @matrix[index + 1][i] = "* "
	  @matrix[row-2 - index][i] = "* "
	  i += 1
	end

	1.upto(row - 2) do |index|
	  @matrix[index][i] = "* "
	end

	#eyes
	@matrix[5][6] = "/\\ "
	@matrix[5][4] = "/\\"

	#smile
	@matrix[8][4] = "\\ "
	@matrix[9][5] = "* "
	@matrix[9][6] = "* "
	@matrix[9][7] = "* "
	@matrix[9][8] = "* "
	@matrix[8][9] = "/ "

  end
 
  def print_matrix(row, column)
  	@matrix.each do |e| 
  	  Curses.setpos(row, column)
      e.each { |value| Curses.addstr(value) } 
  	  Curses.addstr("\n")  
	  row = row + 1
  	end
  
  	Curses.refresh
  	sleep(0.15)
  end


end


ROW = 13
COLUMN = 25

start_x = 80
start_y = 10
Curses.init_screen
Curses.nl
Curses.noecho			
Curses.curs_set(0)

#define ctr+c signal
Signal.trap(2, proc { }) 

fish = Fish.new(ROW, COLUMN)
fish.set_matrix(ROW)

start_x.times do |n|  
  fish.print_matrix(start_y + n % 4, start_x)
  start_x = start_x - 1
  Curses.clear
end

Curses.close_screen

