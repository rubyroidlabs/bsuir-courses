system 'clear'

count=0

animation1 = []


animation1[0] = '   (\__/)  '
animation1[1] = %q(   (='.'=)  )
animation1[2] = '    E[:]|||||[:]З  '
animation1[3] = %q(   (")_(")  )


animation2 = []

animation2[0] = '   (\__/)  '
animation2[1] = %q(   (='.'=)  )
animation2[2] = '    E[:]||[:]З  '
animation2[3] = %q(   (")_(")  )

loop do
  system 'clear'
  count += 1
  if count % 2 == 0
    puts animation1
    animation1.map! do |s|
      " "+ s
    end
  else
    puts animation2
    animation2.map! do |s|
       " "+ s
    end
  end
  sleep (0.2)
end