#!/usr/bin/ruby

require 'io/console'

animation = 
%Q[____________*_____*,
___________*_*****_*,
__________*_(O)_(O)_*,
_________**____V____**,
_________**_________**,
_________**_________**,
__________*_________*,
___________***___***].split

winsize = IO.console.winsize

animation_length = animation.max.length

limit_size = winsize[1] - winsize[1] % animation_length

def sleep_and_clear
	sleep 0.03
	system "clear"
end

loop do|a|
  animation_length.upto(limit_size) do |b|
    animation.map! {|e| e.rjust(e.length + 1)}
	sleep_and_clear
	puts animation
  end
  
  limit_size.downto(animation_length) do |c|
	animation.map! {|e| e.slice!(1..-1)}
	sleep_and_clear
	puts animation
  end
end




