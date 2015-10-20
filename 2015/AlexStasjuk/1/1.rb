require 'curses'
include Curses

class Car
  def initialize()
    @image1 = [
  '                                         AIgg',
  '                                     gggggggggg ',
  '                                  ggggggggggg0gg',
  '                               ggggggggggggggggggg',
  '      gg     ggggggg         gggggggggggg      ggggg',
  '  ggggggggggggggggggggggggggggggggggggggg',
  ' gggggg  ggggggggggggggggggggggggggggggg',
  'gggggg   gggggggggggggggggggggggggggggg',
  'ggggg    ggggggggggggggggggggggggggggg',
  'gggg     ggggggggggggggggggggggggggggg',
  'gg        ggggggggggggggggggggggggggg',
  '         ggggggggg  gggggggggggggggggg',
  '      gggggggggggg             ggggggg',
  '     gggg    gggg                ggggg',
  '     ggg      ggg                  gggg',
  '     gg      gggg          ggg   ggggggggg',
  '    ggg       ggg            gggggg    ggg',
  '   ggg         ggg                       gg',
  '   gg           ggg                       gg',
  '                 gggg                     ggg',
  '                 gggg                     ggg']

    @image2 = [
  '                                        AIgg',
  '                                     gggggggggg ',
  '                                  ggggggggggg0gg',
  '                               ggggggggggggggggggg',
  '      gg     ggggggg         gggggggggggg      ggggg',
  '  ggggggggggggggggggggggggggggggggggggggg',
  ' gggggg  ggggggggggggggggggggggggggggggg',
  'gggggg   gggggggggggggggggggggggggggggg',
  'ggggg    ggggggggggggggggggggggggggggg',
  'gggg     ggggggggggggggggggggggggggggg',
  'gg        ggggggggggggggggggggggggggg',
  '           gggggggg gggggggggggggggggg',
  '            gggggggg            ggggggg',
  '             ggggggg              ggggg',
  '              gggggggg            gggggg',
  '              gggg  ggggg       ggg  gggg',
  '              gggg    gggg     ggg    ggg',
  '              ggg       gggg   ggg      gg',
  '            ggg          ggg  ggg     gg',
  '           ggg            gg  ggg    ggg',
  '         ggg                   ggg    gg']
  end

  def print(y, x, item)
    k = 0
    while (k < @image1.length)
      Curses.setpos(y + k, x)
      if (item==0)
      Curses.addstr(@image1[k])
      else
      Curses.addstr(@image2[k])
      end 
      k += 1
    end
    Curses.refresh
  end
end

car = Car.new()
Curses.init_screen
Curses.nl
Curses.noecho
Curses.curs_set(0)
i = 0
Y = Curses.lines / 5
X = Curses.cols / 2
while i < 70
  car.print(Y, i, i%2)
  sleep(0.1)
  i += 1
  Curses.clear
end
