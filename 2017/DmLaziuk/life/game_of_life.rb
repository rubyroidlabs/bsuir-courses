class GameOfLife
  X_SIZE = 100
  Y_SIZE = 50
  def initialize
    @generation = [''] * Y_SIZE
    @generation.map! do
      str = ''
      X_SIZE.times { str << (rand(3).zero? ? '*' : ' ') }
      str
    end
  end

  def run
    next_generation = []
    (0...Y_SIZE).each do |y|
      str = ' ' * X_SIZE
      (0...X_SIZE).each do |x|
        current = @generation[y][x]
        count = count_neighbours(y, x)
        str[x] = '*' if current == ' ' && count == 3
        str[x] = '*' if current == '*' && [2, 3].include?(count)
      end
      next_generation << str
    end
    @generation = next_generation
  end

  def count_neighbours(y, x)
    count = 0
    count += 1 if @generation[(y + 1) % Y_SIZE][(x - 1) % X_SIZE] == '*'
    count += 1 if @generation[(y + 1) % Y_SIZE][x % X_SIZE] == '*'
    count += 1 if @generation[(y + 1) % Y_SIZE][(x+1) % X_SIZE] == '*'
    count += 1 if @generation[y % Y_SIZE][(x - 1) % X_SIZE] == '*'
    count += 1 if @generation[y % Y_SIZE][(x + 1) % X_SIZE] == '*'
    count += 1 if @generation[(y - 1) % Y_SIZE][(x - 1) % X_SIZE] == '*'
    count += 1 if @generation[(y - 1) % Y_SIZE][x % X_SIZE] == '*'
    count += 1 if @generation[(y - 1) % Y_SIZE][(x + 1) % X_SIZE] == '*'
    count
  end

  def print_board
    puts @generation
  end
end
