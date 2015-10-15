lines = File.readlines('copter1.txt')
lines2 = File.readlines('copter2.txt')

20.times do
  puts lines
  sleep(0.2)
  system('clear')
  puts lines2
  sleep(0.2)
  system('clear')
	end
