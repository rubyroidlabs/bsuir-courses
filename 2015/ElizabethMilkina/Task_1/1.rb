first = File.open("txt/1.txt") do |file|
file.read
end
second = File.open("txt/2.txt") do |file|
file.read
end
third = File.open("txt/3.txt") do |file|
file.read
end
fourth = File.open("txt/4.txt") do |file|
file.read
end
fifth= File.open("txt/5.txt") do |file|
file.read
end
sixth= File.open("txt/6.txt") do |file|
file.read
end
seventh = File.open("txt/7.txt") do |file|
file.read
end
eighth= File.open("txt/8.txt") do |file|
file.read
end
ninth= File.open("txt/9.txt") do |file|
file.read
end

array=[first, second, third, fourth, fifth, sixth, seventh, eighth, ninth]
b="OK\n"
a=""

begin
   puts "Please, move your terminal in full-screen mode. Then enter OK (Only uppercase letters in English)."
   a=gets
end while a!=b

for j in 1..2
	for i in 0..8
		puts array[i]
		sleep(0.15)
		puts "\e[H\e[2J"
	end
	for i in 6..8
		puts array[i]
		sleep(0.15)
		puts "\e[H\e[2J"
	end
	for i in 6..8
		puts array[i]
		sleep(0.15)
		puts "\e[H\e[2J"
	end
end