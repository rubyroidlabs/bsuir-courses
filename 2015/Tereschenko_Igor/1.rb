require_relative 'frames.rb'
require 'colors'
require 'curses'
include Curses

Curses.init_screen
begin
    curs_set 0
    loop do
        clear
        addstr(FRAME1)
        refresh
        sleep 0.5
        clear
        addstr(FRAME2)
        refresh
        sleep 0.5
    end
end

