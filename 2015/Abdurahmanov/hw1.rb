# !/usr/bin/env ruby
# Bear ride
# @version 0.3.9.9
# @author D.Abdurakhmanov
# Global variables $s1-s6, $t1-t27
require_relative './lib/character.rb'
require_relative './lib/simpleEncoder.rb'
require 'colored'
# animation engine
class Bear
 def initialize(ii = 1)
  @ii = ii
 end
 def anim
  s0 = '  '
  i = 1
  loop do
   system 'clear'
   s0 += '  '
   puts (s0 + $s1 + "\n" + s0 + $s2 + "\n" + s0 + $s3).red
   puts (s0 + $s4 + "\n" + s0 + $s5 + "\n" + s0 + $s6).green
   sleep 0.09
   i += 1
   if i == @ii
  break loop
   end
  end
 end
end
b = Bear.new(15)
b.anim
