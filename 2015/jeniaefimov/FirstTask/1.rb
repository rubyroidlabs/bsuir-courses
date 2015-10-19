#!/usr/bin/env ruby

i = 30
j = 0
s = ['    ^_^', '  =(O.O)=', '   (  _ )--,', '    !! !!']
i.times do
  system 'clear'
  if i & 2 == 0
    puts "\n"
  end
  4.times do
    if i > 0
      i.times { print ' ' }
      puts s[j]
      j += 1
    end
  end
  j = 0
  i -= 1
  sleep(1.0 / 8.0)
end
system('clear')
