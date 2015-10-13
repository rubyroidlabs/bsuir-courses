system 'clear'

count=0

animation1 = []

animation1[0] = '-_-_-_-_-_-_-  ,------, '
animation1[1] = '_-_-_-_-_-_-_~|   /|_/| '
animation1[2] = '-_-_-_-_-_-_-~|__( ^_ ^)'
animation1[3] = %q(_-_-_-_-_-_-_  ""  "" )

animation2 = []

animation2[0] = '_-_-_-_-_-_-_  ,------, '
animation2[1] = '-_-_-_-_-_-_-~|   /|_/| '
animation2[2] = '_-_-_-_-_-_-_~|__( ^ _^)'
animation2[3] = %q(-_-_-_-_-_-_- ""  ""  )

loop do
  system 'clear'
  count += 1
  if count % 2 == 0
    puts animation1
    animation1.map! do |s|
      " " + s
    end
  else
    puts animation2
    animation2.map! do |s|
      " " + s
    end
  end
  sleep (0.1)
end
