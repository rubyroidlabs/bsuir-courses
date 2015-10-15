filestrings = ["text1.txt", "text2.txt", "text3.txt", "text4.txt", "text5.txt", "text6.txt", "text7.txt", "text8.txt"]

i = 0
while i <= 10
 filestrings.each do |filename|
  IO.foreach(filename) do |line|
   puts line 
  end
  sleep 0.2
  system("clear")
 end
 i += 1
end


