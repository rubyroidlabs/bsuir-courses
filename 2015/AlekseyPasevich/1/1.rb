source=File.open("cup1.txt")
cup1=source.to_a
source=File.open("cup2.txt")
cup2=source.to_a
20.times do 
  puts "\e[2J"
  puts cup1
  sleep 0.2
  puts "\e[2J"
  puts cup2
  sleep 0.2
  end
puts "\e[2J"
source.close
