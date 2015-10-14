str = File.read('1.txt')
system 'clear'
5.times do
  for i in 0..5
    puts str[(i * 456)..((i + 1) * 456 - 1)]
    sleep(0.30)
    system 'clear'
  end
end
