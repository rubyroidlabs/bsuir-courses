train = [
['                                                              '],
['  FFFFFF  U     U  CCCCCCC  K  KK      GGGGGG   GGGGGG        '],
['  F       U     U  C        KKK        G        G             '],
['  FFFFF   U     U  C        K          G  GGG   G  GGG        '],
['  F        U   U   C        KKK        G    G   G    G        '],
['  F        UUUUU   CCCCCCC  K  KK      GGGGGG   GGGGGG        ']]

train.map! {|x| x = x[0].split(//)}#Useless assignment to variable - x.Use 2 (not 1) spaces for indentation.

while true
  system 'clear'
  train.each do |x|
    puts x.join
    x.rotate!
  end
  sleep 0.2
end
