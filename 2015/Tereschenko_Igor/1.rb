require 'curses'
include Curses

frame1 = '
         _____________________  
        |_____________________| 
        /     |    |    |    |  
       /      |    |    |    |  
      /       |    |    |    |  
    _/_      _|_  _|_  _|_  _|_ 
   /   \    /   \/   \/   \/   \
   \___/    \___/\___/\___/\___/'

frame2 = '
         _____________________
        |_____________________|
         |    |    |    |     \
         |    |    |    |      \
         |    |    |    |       \
        _|_  _|_  _|_  _|_      _\_
       /   \/   \/   \/   \    /   \
       \___/\___/\___/\___/    \___/'

Curses.init_screen
begin
    curs_set 0
    loop do
        clear
        addstr(frame1)  
        refresh
        sleep 0.5
        clear
        addstr(frame2)
        refresh
        sleep 0.5
    end
end
