#!/usr/bin/env ruby

require "rubygems"
require "bundler/setup"

require "artii"
require "colorize"
require "terminfo"

# Scrolls your text
class Scroller
  BAND_WIDTH = 16
  COLORS = [:red, :yellow, :green, :cyan, :blue, :magenta]
  WIDTH_GAP = 0 # set to positive to allow smooth window contraction
  SLEEP_DELAY = 0.04

  def initialize(text)
    @lines = Artii::Base.new(font: "roman").asciify(text + "   ").split("\n")
    @lines.map! { |line| line.split(//) }
  end

  def play
    # dynamic screenwidth adjustment
    old_width = 0
    loop do
      width = TermInfo.screen_size[1]
      puts width == old_width ? "\033[1;1H" : "\033c"
      old_width = width
      @lines.each { |l| puts decorate(l.rotate!.cycle.take(width - WIDTH_GAP)) }
      puts @screen_width
      sleep SLEEP_DELAY
    end
  end

  def decorate(line)
    line.each_slice(BAND_WIDTH).map(&:join).zip(COLORS.cycle)
      .map { |s, c| s.colorize(c) }.join
  end
end

if $PROGRAM_NAME == __FILE__
  name = ENV["USER"]
  message = rand < 0.7 ? "Hello, #{name}!" : "#{name}, you're drunk. Go home!"
  Scroller.new(message).play
end
