class GameOfLife

  attr_accessor :field

  def initialize (m, n)
    @m, @n = m, n
    @field = Array.new(m) { Array.new(n) { rand(2) } }
  end

  def neighbors (x, y)
    s=0
    (-1..1).to_a.each do |i|
      (-1..1).to_a.each { |j| s += @field[(x+i) % @m][(y+j) % @n] }
    end
    s-@field[x][y]
  end

  def rules (x, y)
    if (neighbors(x ,y) == 3)
      return 1
    elsif (@field[x][y] == 1 && neighbors(x, y) == 2)
      return 1
    else
      return 0
    end
  end

  def step
    field_copy = Array.new(@m) { Array.new(@n) { 0 } }
    @field.each_with_index do |row, i|
      row.each_with_index do |elem, j|
        field_copy[i][j] = rules(i, j)
      end
    end
    @field = field_copy
  end

end


