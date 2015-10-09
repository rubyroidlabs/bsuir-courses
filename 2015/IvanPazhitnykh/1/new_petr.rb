# everything stops working if you change the size of the console
MAGIC_NUMBER = 99
MESSAGE =
'Это поросёнок Пётр и он эмигрирует из РФ позаимствовав некачественную'\
'сельскохозяйственную технику'
space = ' '
i = 0

image = []

Dir['*.txt'].each do |name|
  image[i] = File.read(name).split("\n")
  i += 1
end

loop do
  if (i == MAGIC_NUMBER)
    i = 0
    space = ' '
  end
  puts "\e[H\e[2J"
  puts MESSAGE

  if (i % 4) == 0 || (i % 4) == 1
    image[0].each { |line| puts space + line }
  else
    image[1].each { |line| puts space + line }
  end

  sleep(0.1)
  space += ' '
  i += 1
end
