require 'colorize'

def colorization(input_text, indicator)
  input_text.size.times do |i|
    case indicator
      when 1
        if input_text[i] == '%'
          print input_text[i].red
        else
          print input_text[i]
        end
      when 2, 4
        if input_text[i] == '@'
          print input_text[i].yellow
        else
          print input_text[i]
        end
      when 3
        if input_text[i] == '&'
          print input_text[i].green
        else
          print input_text[i]
        end
      else
        print input_text[i]
      end
    end
end

input_source = File.open("./inputForTask.txt").read
counter = 0
50.times do |i|
  counter += 1
  colorization(input_source, counter)
  sleep(0.3)
  if counter == 4
    counter = 0
  end
  puts "\e[H\e[2J"
end
