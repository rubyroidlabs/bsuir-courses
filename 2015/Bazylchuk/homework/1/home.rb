#!/usr/bin/env ruby
# coding: utf-8
 
require 'curses'
 
Curses.init_screen
 
text = "TEXT"
attrs = {
  normal: Curses::A_NORMAL, 
  standout: Curses::A_STANDOUT,
  underline: Curses::A_UNDERLINE,
  reverse: Curses::A_REVERSE,
  blink: Curses::A_BLINK}
 
Curses.setpos(0, 0)
Curses.addstr('-' * 48)
Curses.setpos(1, 0)
Curses.addstr(sprintf("%-10s %-32s %s", "attribute", "value", "view"))
Curses.setpos(2, 0)
Curses.addstr('-' * 48)
attrs.each_with_index do |(name, attr), i|
  Curses.setpos(i + 3, 0)
  Curses.addstr(sprintf("%-10s %032b ", name.to_s, attr))
  Curses.attron(attr)
  Curses.addstr(text)
  Curses.attroff(attr)
end
Curses.setpos(attrs.size + 3, 0)
Curses.addstr('-' * 48)
 
Curses.refresh
Curses.getch
 
Curses.close_screen