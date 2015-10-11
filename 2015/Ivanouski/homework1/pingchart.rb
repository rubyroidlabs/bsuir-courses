#!/usr/bin/env ruby

# Ping chart
# @version 0.1.0
# @author S.Ivanouski

system 'clear'

ping_array = []

100.times do
  ping_time = `ping -c 1 google.com | head -2 | tail -1 | awk '{print $7}'`
  var0 = ping_time.delete('time=')
  ping_array.push var0.to_i
end

ping_array.each do |a| puts '+' + ('-' * a)
  sleep 0.05
end

exit 0
