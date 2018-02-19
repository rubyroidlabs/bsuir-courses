#!/usr/bin/env ruby

require 'curses'
require 'pry'

class Image
  def initialize(file_name)
    file = File.open(file_name)
    @picture = file.to_a
    file.close
  end

  def draw
    puts @picture
  end

  def width
    @picture[0].length
  end

  def height
    @picture.length
  end

  def to_s
    result = ''
    height.times { |i| result += @picture[i] }
    result
  end
end

class Animator
  def initialize
    @gun = Image.new('gun.txt')
    @cartridge = Image.new('cartridge.txt')
    @offsetx_of_cartridge = @gun.width
    @offsety_of_cartridge = 1
    @gun_string = @gun.to_s
    @cartridge_string = @cartridge.to_s
    @height_of_gun = @gun.height
    @width_of_cartridge = @cartridge.width
  end

  def animate
    Curses.init_screen
    coordx_of_gun = 0
    coordy_of_gun = (Curses.lines - @height_of_gun) / 2
    coordx_of_cartridge = coordx_of_gun + @offsetx_of_cartridge
    coordy_of_cartridge = coordy_of_gun + @offsety_of_cartridge
    begin
      while coordx_of_cartridge < Curses.cols - @width_of_cartridge
        draw_frame(coordx_of_gun, coordy_of_gun,
                  coordx_of_cartridge, coordy_of_cartridge)
        coordx_of_cartridge += 10
        sleep 0.1
      end
    ensure
      Curses.close_screen
    end
  end

  private

  def draw_frame(coordx_of_gun, coordy_of_gun,
  coordx_of_cartridge, coordy_of_cartridge)
    Curses.clear
    draw_gun(coordx_of_gun, coordy_of_gun)
    draw_cartridge(coordx_of_cartridge, coordy_of_cartridge)
    Curses.refresh
  end

  def draw_gun(coordx, coordy)
    Curses.setpos(coordy, coordx)
    Curses.addstr(@gun.to_s)
  end

  def draw_cartridge(coordx, coordy)
    Curses.setpos(coordy, coordx)
    Curses.addstr(@cartridge.to_s)
  end
end

animator = Animator.new
amount_of_shots = 10
amount_of_shots.times { animator.animate }
