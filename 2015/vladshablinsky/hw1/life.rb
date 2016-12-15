class Life
  WIDTH = 60
  HEIGHT = 28
  SELF_FILLED = 10
  SLEEP_TIME = 0.01
  MAX_COUNTER = 150

  def initialize
    @field = Array.new(HEIGHT)
    @field.map! { Array.new(WIDTH, 0) }
    @temp = Array.new(HEIGHT)
    @temp.map! { Array.new(WIDTH, 0) }
    @counter = 0
  end

  def generate
    50.times do
      @temp[HEIGHT / 3 + rand(HEIGHT / 4)][WIDTH / 3 + rand(WIDTH / 4)] = \
      SELF_FILLED
    end
  end

  def changed?
    HEIGHT.times do |i|
      WIDTH.times do |j|
        return true if @field[i][j] != @temp[i][j]
      end
    end
    false
  end

  def finished?
    @counter > MAX_COUNTER
  end

  def recalc
    @counter += 1
    HEIGHT.times do |i|
      WIDTH.times do |j|
        @temp[i][j] = 0
        (-1..1).each do |dx|
          (-1..1).each do |dy|
            next if dx == 0 && dy == 0
            if i + dx >= 0 && i + dx < HEIGHT
              if j + dy >= 0 && j + dy < WIDTH
                @temp[i][j] += @field[i + dx][j + dy] / 10
              end
            end
          end
        end
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
    print '#' * (WIDTH + 2), "\n"
    HEIGHT.times do |i|
      print '#'
      WIDTH.times do |j|
        @field[i][j] = @temp[i][j]
        if @field[i][j] / 10 != 0
          print '*'
        else
          print ' '
        end
      end
      print "#\n"
    end
    print '#' * (WIDTH + 2), "\n"
  end

  def run
    generate
    until finished?
      puts "\e[H\e[2J\n"
      paint
      recalc
      sleep(SLEEP_TIME)
    end
    puts "\e[H\e[2J"
  end
end

my_life = Life.new
my_life.run
