image = []
b = 'OK'
a=''

(1..9).each { |i|
  file = File.open("txt/#{i.to_s}.txt", 'r')
  image[i] = file.read
}

while a.chomp != b
  begin
    puts 'Please, move your terminal in full-screen mode.'\
    'Then enter OK (Only uppercase letters in English).'
    a = gets
  end
end

(1..2).each {
  (1..9).each { |i|
    puts image[i]
    sleep(0.15)
    system 'clear'
  }
  (7..9).each { |j|
    puts image[j]
    sleep(0.15)
    system 'clear'
  }
  (7..9).each { |k|
    puts image[k]
    sleep(0.15)
    system 'clear'
  }
}
