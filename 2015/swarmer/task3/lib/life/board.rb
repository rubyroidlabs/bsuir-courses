module Life
  class Board
    attr_reader :width, :height

    def initialize(width, height)
      if width < 3 || height < 3
        raise ArgumentError.new("Life Board dimensions must be bigger than 3")
      end

      @width = width
      @height = height
      @cells = Array.new(height) do
        Array.new(width) { false }
      end
    end

    def [](x, y)
      wx, wy = wrapped_coords(x, y)
      @cells[wy][wx]
    end

    def []=(x, y, value)
      wx, wy = wrapped_coords(x, y)
      @cells[wy][wx] = value
    end

    def to_a
      clone_2d_array(@cells)
    end

    def update_from_array(cells)
      @cells = clone_2d_array(cells)
    end

    def self.from_array(cells)
      width = cells[0].size
      height = cells.size
      board = new(width, height)
      board.update_from_array(cells)
      board
    end

    def self.from_text(text)
      lines = text.split("\n")

      width = lines[0].size
      height = lines.size
      board = Life::Board.new(width, height)

      lines.each_with_index do |line, y|
        line.each_char.with_index do |char, x|
          board[x, y] = (char == "#")
        end
      end

      board
    end

    def count_neighbors(x, y)
      count = 0

      each_neighbor(x, y) do |nx, ny, alive|
        count += 1 if alive
      end

      count
    end

    def clone
      self.class.from_array(@cells)
    end

    def each
      (0...height).each do |y|
        (0...width).each do |x|
          yield x, y, self[x, y]
        end
      end
    end

    def each_neighbor(x, y)
      (-1..1).each do |dy|
        (-1..1).each do |dx|
          next if dx == 0 && dy == 0

          nx = x + dx
          ny = y + dy
          yield nx, ny, self[nx, ny]
        end
      end
    end

    def tick
      old_board = clone()
      each do |x, y, alive|
        neighbor_count = old_board.count_neighbors(x, y)

        if alive
          self[x, y] = (2..3).include?(neighbor_count)
        else
          self[x, y] = (neighbor_count == 3)
        end
      end
    end

    private

    def clone_2d_array(arr)
      arr.map { |row| row.clone }
    end

    def wrapped_coords(x, y)
      [x % width, y % height]
    end
  end
end
