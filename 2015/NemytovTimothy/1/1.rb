train = [
['                                                              '],
['  FFFFFF  U     U  CCCCCCC  K  KK      GGGGGG   GGGGGG        '],
['  F       U     U  C        KKK        G        G             '],
['  FFFFF   U     U  C        K          G  GGG   G  GGG        '],
['  F        U   U   C        KKK        G    G   G    G        '],
['  F        UUUUU   CCCCCCC  K  KK      GGGGGG   GGGGGG        ']]

train.map! { |x| x[0].split(//) }

loop do
  system 'clear'
  train.each do |x|
    puts x.join
    x.rotate!
  end
  sleep 0.2
end
