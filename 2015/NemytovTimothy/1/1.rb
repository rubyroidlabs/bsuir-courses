train = [#Use 2 spaces for indentation in an array, relative to the start of the line where the left bracket is.
#Prefer single-quoted strings when you don't need string interpolation or special symbols.
['                                                              '],
['  FFFFFF  U     U  CCCCCCC  K  KK      GGGGGG   GGGGGG        '],
['  F       U     U  C        KKK        G        G             '],
['  FFFFF   U     U  C        K          G  GGG   G  GGG        '],
['  F        U   U   C        KKK        G    G   G    G        '],
['  F        UUUUU   CCCCCCC  K  KK      GGGGGG   GGGGGG        ']]

train.map! {|x| x = x[0].split(//)}#Useless assignment to variable - x.Use 2 (not 1) spaces for indentation.

while (true)
    system 'clear'
    train.each do |x|
        puts x.join# Use 2 (not 1) spaces for identation
        x.rotate!
    end
    sleep 0.2
end
