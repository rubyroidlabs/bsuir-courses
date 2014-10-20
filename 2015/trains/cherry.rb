require 'curses'

class Image
  attr_reader :entity, :length

  def initialize entity
    @entity = entity
    @length = count_length
  end
  def draw y, x, first_col = 0, last_col = @length - 1
    Curses.setpos y, x
    @entity.each do |str|
      Curses.addstr str[first_col..last_col] if first_col < str.length
      Curses.setpos y += 1, x
    end
    Curses.refresh
  end
  def move
    x = max_x = Curses.cols - 1
    y = 0
    while x > -@length
      if x >= 0
        self.draw y, x, 0, max_x - x
      else
        self.draw y, 0, -x, max_x
      end
      x -= 1
      sleep(0.05)
      self.edit_entity if x % 8 == 0
      Curses.clear
    end
  end

  private
  def count_length
    max_length = 0
    @entity.each { |str| max_length = str.length if str.length > max_length}
    max_length
  end
end

Curses.init_screen
Curses.curs_set 0

cherry_entity = [
                  '   #####     ',
                  '   ########   ',
                  '    ###   ######',
                  '     ###     ####',
                  '       ####      #',
                  '         #########',
                  '          ########',
                  '               ####',
                  '              #  #',
                  '             ##   ##',
                  '            #       #',
                  '            #         ##',
                  '           ##           #',
                  '          ##             ##',
                  '        ###          ##########',
                  '  ###########    ##   #### ###',
                  ' ##    #######   #  #####  ####',
                  '##    ##### ###  ### ## ## ####',
                  '#     #########  #############',
                  '###############  ##########',
                  '  #############   #########',
                  '   ##########    '
                 ]

cherry = Image.new cherry_entity
class << cherry
  def edit_entity
    @entity.each do |str|
      if str['#']
        str.gsub! '#', '_'
      else
        str.gsub! '_', '#'
      end
    end
  end
end
cherry.move
Curses.close_screen