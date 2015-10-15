class GameOfLife

  attr_reader :rows, :columns, :field

  def initialize(rows, columns, field = [])
    @rows = rows
    @columns = columns
    if field.empty?
      @field = random_init
    else
      field.each do |row|
        unless field.length == @rows && row.length == @columns
          raise ArgumentError
        end
      end
      @field = field
    end
  end

  def next_state
    next_state = []
    0.upto(@rows - 1) do |i|
      row = []
      0.upto(@columns - 1) do |j|
        if cell_is_alive?(i, j)
          case alive_neighbours(i, j)
          when 0..1 then row[j] = 0
          when 2..3 then row[j] = 1
          when 4..8 then row[j] = 0
          end
        else
          if alive_neighbours(i, j) == 3
            row[j] = 1
          else
            row[j] = 0
          end
        end
      end
      next_state[i] = row
    end
    @field = next_state
  end

  def cell_is(i, j)
    if @field[i][j] == 1
      'alive'
    else
      'dead'
    end
  end

  private

  def cell_is_alive?(i, j)
    if @field[i][j] == 1
      true
    else
      false
    end
  end

  def random_init
    field = []
    0.upto(@rows - 1) do |i|
      row = []
      0.upto(@columns - 1) do |j|
        row[j] = Random.new.rand(2)
      end
      field[i] = row
    end
    field
  end

  def alive_neighbours(y, x)
    count = 0
    (y - 1).upto(y + 1) do |i|
      i = 0 if i == @rows
      (x - 1).upto(x + 1) do |j|
        j = 0 if j == @columns
        next if y == i && x == j
        count += 1 if @field[i][j] == 1
      end
    end
    count
  end
end
