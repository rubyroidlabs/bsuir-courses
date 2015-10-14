image = []
b = "OK\n"
a = ""

for i in 1..9
  file = File.open('txt/'+i.to_s+'.txt', 'r')
  image[i] = file.read()
end

while a != b
  begin
    puts 'Please, move your terminal in full-screen mode. Then enter OK (Only uppercase letters in English).'
    a = gets
  end
end

(1..2).each { |j|
  (1..9).each { |i|
    puts image[i]
    sleep(0.15)
    system 'clear'
  }
  (7..9).each { |i|
    puts image[i]
    sleep(0.15)
    system 'clear'
  }
  (7..9).each { |i|
    puts image[i]
    sleep(0.15)
    system 'clear'
  }
}
