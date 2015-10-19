# everything will stop working if you change the size of the console
ARGV[0] ? counter_exe = ARGV[0].to_i : counter_exe = 1
MAGIC_NUMBER = 104
i = 0
space = ' '
image = []
direction = 0
Dir['*.txt'].each do |name|
  image[i] = File.read(name).split("\n")
  i += 1
end
i = 0
counter_exe.times do
  i = 0
  direction = 0
  loop do
    if (i == MAGIC_NUMBER) && (direction == 0)
      direction = 1
    elsif (i == 0) && (direction == 1)
      break
    end
    puts "\e[H\e[2J"
    image[i % 30].each { |line| puts space + line }
    sleep(0.1)
    if direction == 0
      space += ' '
      i += 1
    elsif direction == 1
      space.slice!(i)
      i -= 1
    end
  end
end
system('clear')
