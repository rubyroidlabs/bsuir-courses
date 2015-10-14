require  'pry'
require  'colorize'

def color(string_file)
	string_file.size.times do |i|
     if string_file[i] == "█" 
     print string_file[i].red
     elsif string_file[i] == "▞"
     	print string_file[i].green
     else
       print string_file[i].blue
     end
   end


end

1000.times do |i|
	kadr = i % 18
	filename = "#{kadr}.txt"
	f = File.open(filename, "r")
	file_body = f.read
	#binding.pry
	color(file_body)
	#puts file_body.red		
	sleep(0.1)
	puts "\e[H\e[2J"
end

