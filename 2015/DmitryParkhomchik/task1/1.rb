
lines = File.readlines('animation.txt')
counter = 0

lines.each do |line|
  counter += 1
  puts line
  if counter > 32
    counter = 0
    sleep(0.2)
    system('clear')
  end
end
