#!/usr/bin/env ruby

require 'terminfo'

# Terminal sigarette
class Sijka
  SLEEP_TIME = 0.02

  def initialize(file_name = "#{File.dirname(__FILE__)}/picture.txt")
    @img = File.open(file_name) { |file| file.read.split("\n") }
    @movement_range = TermInfo.screen_size[1] - @img.first.length
  end

  def right_move
    @movement_range.times do
      system 'clear'
      puts @img
      sleep(SLEEP_TIME)
      @img.map! { |line| line.insert(0, ' ') }
    end
  end

  def reverse_img
    @img.map! do |line|
      line[0..@movement_range - 1] + line[@movement_range..-1].reverse
    end
  end

  def left_move
    @movement_range.times do
      system 'clear'
      puts @img
      sleep(SLEEP_TIME)
      @img.map! { |line| line[1..-1] }
    end
  end
end

a = Sijka.new
a.right_move
a.reverse_img
a.left_move
puts 'All was smoking!'
sleep(1.3)
system 'clear'
