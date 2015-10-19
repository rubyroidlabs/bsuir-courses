require 'pry'
require 'colorize'

def symbol_color(string_file)
  string_file.size.times do |i|
    if string_file[i] == '█' 
      print string_file[i].red # print fast car
    elsif string_file[i] == '▞'
      print string_file[i].green # print border
    else
      print string_file[i].blue # print slow car
    end
  end
end

1000.times do |i|
  kadr = i % 18
  filename = "#{kadr}.txt"
  f = File.open(filename, 'r')
  file_body = f.read
  symbol_color(file_body)
  sleep(0.1)
  puts "\e[H\e[2J"
end
