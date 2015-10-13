
lines = File.readlines("anim.txt")
counter = 0;
space = ""

system("clear")

20.times do
  space += "   "
  lines.each do |line| 
    puts space + line
    counter += 1
    if counter > 6 
      sleep(0.08)
      system("clear")
      counter = 0
    end
  end
end
