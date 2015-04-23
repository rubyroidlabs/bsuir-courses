#!/usr/bin/env ruby
require "curses"
include Curses

init_screen
nl
noecho
curs_set(0)

ypos = lines / 2
xpos = cols / 2

down = true
right = true

while TRUE
  clear
  setpos(ypos - 3, xpos);   addstr("    .--.")
  setpos(ypos - 2, xpos);   addstr("   |o_o |")
  setpos(ypos - 1, xpos);   addstr("   |:_/ |")
  setpos(ypos,     xpos);   addstr("  //   \\ \\")
  setpos(ypos + 1, xpos);   addstr(" (|     | )")
  setpos(ypos + 2, xpos);   addstr("/'\\_   _/`\\")
  setpos(ypos + 3, xpos);   addstr("\\___)=(___/")

  if down
    ypos += 1
  else
    ypos -= 1
  end
  if ypos > (lines - 5)
    down = false
  end
  if ypos < 4
    down = true
  end
  if right
    xpos += 1
  else
    xpos -= 1
  end
  if xpos > (cols - 12)
    right = false
  end
  if xpos < 1
    right = true
  end
  
  refresh
  sleep(0.1)
end
