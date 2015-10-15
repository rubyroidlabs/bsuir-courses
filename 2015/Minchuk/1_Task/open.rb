require 'colored'

FILES_COUNT = 11
CONSOLE_LENGTH = 120

max_length = -1
cut_space = 0
file_number = -1

lines = Array.new(FILES_COUNT, [])
(0...FILES_COUNT).each do |i|
  lines[i] = (File.read("#{i}.txt").split("\n"))
end

while CONSOLE_LENGTH + max_length - cut_space > 0
  file_number = (file_number + 1) % FILES_COUNT
  max_length_line = lines[file_number].max { |a, b| a.length <=> b.length }.length

  if max_length_line >= max_length
    max_length = max_length_line
  end

  lines[file_number].each do |line|
  new_line = ' ' * CONSOLE_LENGTH + line
  cut_line = new_line.slice(cut_space, CONSOLE_LENGTH)
  if !cut_line.nil?
    if cut_line.include? '1' or cut_line.include? '0'
      puts cut_line.gsub(/[10]/, '1' => '1'.red, '0' => '0'.black)
    else
      puts cut_line
    end
  else
    puts ''
  end
  end
  cut_space += 2
  sleep(0.1)
  system('clear')
end
system('clear')
