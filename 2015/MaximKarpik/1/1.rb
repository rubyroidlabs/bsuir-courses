source=File.readlines("emb2.txt")

20.times do 
  (0..26).to_a.each do |i|
    (0..53).to_a.each do |j|
      source[i][j] == ' ' ? source[i][j] = '0' : source[i][j] = ' '
    end
  end
  sleep 0.3
  system 'clear'
  puts source
end