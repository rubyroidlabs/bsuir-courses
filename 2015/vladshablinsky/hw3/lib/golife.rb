require 'terminfo'
require 'curses'

class GOLife
  HEIGHT, WIDTH = TermInfo.screen_size
  SELF_FILLED = 10
  SLEEP_TIME = 0.01
  MAX_COUNTER = 150

  attr_reader :field, :temp

  def initialize(width=(WIDTH-2), height=(HEIGHT-2))
    @width = width
    @height = height
    p @width, @height
    @field = Array.new(@height) { Array.new(@width, 0) }
    @temp = Array.new(@height) {Array.new(@width, 0) }
    @counter = 0
  end

  def generate
    @height
    100.times do
      @temp[@height / 3 + rand(@height / 4)][@width / 3 + rand(@width / 4)] = SELF_FILLED
    end
  end

  def cell_changed?(i, j)
    @field[i][j] != @temp[i][j]
  end

  def changed?
    HEIGHT.times do |i|
      WIDTH.times do |j|
        return true if cell_changed?(i, j)
      end
    end
    false
  end

  def finished?
    @counter > MAX_COUNTER
  end

  def update_cell(i, j)
    ans = 0
    (-1..1).each do |dx|
      (-1..1).each do |dy|
        ans += \
          @field[(i + dx + @height) % @height][(j + dy + @width) % @width] / 10
      end
    end
    ans
  end

  def recalc
    @counter += 1
    (@height).times do |i|
      (@width).times do |j|
        @temp[i][j] = update_cell(i, j)
        if @temp[i][j] == 3 || @temp[i][j] == 2
          if @field[i][j] / 10 != 0
            @temp[i][j] += 10
          elsif @temp[i][j] == 3
            @temp[i][j] += 10
          end
        end
      end
    end
  end

  def paint
    print '#' * (@width + 2), "\n"
    @height.times do |i|
      print '#'
      @width.times do |j|
        @field[i][j] = @temp[i][j]
        if @field[i][j] / 10 != 0
          print '*'
        else
          print ' '
        end
      end
      print "#\n"
    end
    print '#' * (@width + 2)
  end

  def run
    #Curses.init_screen
    generate
    until finished?
      puts "\e[H\e[2J\n"
      #Curses.refresh
      paint
      recalc
      sleep(SLEEP_TIME)
    end
    #Curses.close_screen
  end
end
