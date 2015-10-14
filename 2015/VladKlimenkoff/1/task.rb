
r2d2str = File.open('r2d2.txt'){ |file| file.read }
backgroundStr = File.open('background.txt'){ |file| file.read }
r2d2 = r2d2str.split(/\n/)
background = backgroundStr.split(/\n/)

DISTANCE = 45
pic = []

loop do ||
    r2d2.length.upto(DISTANCE) do ||
        r2d2.map! { |r2d2Line| r2d2Line.rjust(r2d2Line.length + 1) }
        pic = backgroundStr.split(/\n/)
        sleep 0.03
        system 'clear'

        (0...(r2d2.length)).each do |i|
            (0...(r2d2[i].length)).each do |j|
                pic[i][j] = r2d2[i][j] if background[i][j] == ' '
            end
        end
        
        puts pic
    end

    DISTANCE.downto( r2d2.length) do |c|
        r2d2.map! { |r2d2Line| r2d2Line.slice!(1..-1) }
        pic = backgroundStr.split(/\n/)
        sleep 0.03
        system 'clear'

        (0..(r2d2.length - 1)).each do |i|
            (0..(r2d2[i].length - 1)).each do |j|
                pic[i][j] = r2d2[i][j] if background[i][j] == ' '
            end
        end

        puts pic
    end
end