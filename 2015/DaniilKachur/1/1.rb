require 'asciiart'
require 'curses'
include Curses

def win_init(height, width)
  width += 6
  win = Window.new(height, width, 0, 0)
  win.setpos(0, 0)
  win
end

def show_pict(window, str_pict)
  window.addstr(str_pict)
  window.refresh
  window.clear
end

init_screen
begin
  crmode

  WIDTH = 60
  HEIGHT = WIDTH + 35
  window = win_init(HEIGHT, WIDTH)
  frame = Array.new(10) { |i| AsciiArt.new("jp/#{i}.jpeg") }

  while true
    frame.each do |i|
      show_pict window, i.to_ascii_art(width: WIDTH)
      sleep 0.01
    end
  end
end
