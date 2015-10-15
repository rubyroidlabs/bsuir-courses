file = File.open("text.txt")
array = Array.new(file.to_a)
(0..125).each do |i|
system('clear')
   puts array.map{|item| ' '*(i) + item}
   sleep 0.05
system('clear')
end
system('clear')
sleep 0.05
system('clear')
