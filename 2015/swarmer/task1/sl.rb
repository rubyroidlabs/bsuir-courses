#!/usr/bin/env ruby
require 'curses'


class AsciiPicture
  attr_reader :lines
  attr_accessor :x, :y

  def initialize(filename, x = 0, y = 0)
    @lines = File.readlines(filename).map(&:chomp)
    @x = x
    @y = y
  end

  def render(window)
    lines.each.with_index do |line, i|
      line.each_char.with_index do |char, j|
        next if char == ' '

        cy = i + y
        cx = j + x
        if !(0...window.maxy).include?(cy) || !(0...window.maxx).include?(cx)
          next
        end

        window.setpos(cy, cx)
        window.addstr(char)
      end
    end
  end
end


DIST = 50
DELAY = 0.02

Curses.init_screen()
Curses.curs_set(0)

window = Curses::Window.new(0, 0, 0, 0)
ruby = AsciiPicture.new("ruby.txt", DIST, 1)
dwi = AsciiPicture.new("dwi.txt", 13, DIST + 2)

DIST.times do
  window.clear()
  ruby.render(window)
  dwi.render(window)
  window.refresh()

  ruby.x -= 1
  dwi.y -= 1
  sleep(DELAY)
end

window.getch()
window.close()
