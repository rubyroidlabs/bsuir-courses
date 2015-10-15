 file = File.open('1.txt')
 arr = file.to_a

 def clear_screen 
   puts "\e[H\e[2J"
 end

 def go(arr)
  arr.insert(0, ' ')
  arr.map { |x| x.insert(0, ' ') }
 end

 (40).times do
   clear_screen
   puts arr
   sleep(0.1)
   go(arr)
 end