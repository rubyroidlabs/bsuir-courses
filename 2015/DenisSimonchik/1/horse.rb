SIZE = 100
file = File.open("image.txt")
horse_arr_1 = file.to_a
file = File.open("image2.txt")
horse_arr_2 = file.to_a
temp1 = Array.new(horse_arr_1)
temp2 = Array.new(horse_arr_2)
(0..SIZE).each do |i|
  system "clear"
  puts temp1
  sleep 0.02
  system "clear"
  puts temp2
  sleep 0.02
  temp1 = horse_arr_1.map { |item| " " * (i) + item }
  temp2 = horse_arr_2.map { |item| " " * (i) + item }
end
