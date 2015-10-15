# Bear ride
# @version 0.3.9
# @author D.Abdurakhmanov
# Global variables $s1-s6, $t1-t27 
#Dir[File.expand_path('./lib/*.rb',__FILE__)].each {|f| require(f)}
require_relative './lib/character.rb'
require_relative './lib/simpleEncoder.rb'
require 'colored'
# animation engine
s0 = ' '
i = 0
loop do 
  system 'clear'
  s0 += ' '
  puts (s0 + $s1 + "\n" + s0 + $s2 + "\n" + s0 + $s3 + "\n" + s0 + $s4 + "\n" + s0 + $s5 + "\n" + s0 + $s6).green
  sleep 0.05
  i += 1
  if i == 30
  break loop
  end
end