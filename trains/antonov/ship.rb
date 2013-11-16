#!/usr/bin/env ruby
require 'terminfo'

class AsciiArt
  def initialize art_file, padding=0
    @lines = File.open(art_file).read.split("\n").map {|x| (' '*padding)+x}
  end

  def [] start, length
    @lines.map{|x| x[start, length] or ''}
  end

  def length
    @lines.map(&:length).max
  end
end

class AsciiAnimation
  CLEAR_ESCAPE_SEQUENCE = "\e[H\e[2J"

  def initialize ascii_art
    @ascii_art = ascii_art
  end

  def play frame_delay=0.1
    0.upto(@ascii_art.length) do |shift|
      show_frame shift
      sleep frame_delay
    end
  end

  def show_frame shift
    term_lines, term_columns = TermInfo.screen_size
    self.class.clear
    @ascii_art[shift, term_columns].last(term_lines).each {|line| puts line}
  end

  def self.clear
    print CLEAR_ESCAPE_SEQUENCE
  end
end

Signal.trap("INT"){
  exit
}

_, term_columns = TermInfo.screen_size
art = AsciiArt.new File.join(__dir__,'art.txt'), term_columns
animation = AsciiAnimation.new art
at_exit { AsciiAnimation.clear }
animation.play
