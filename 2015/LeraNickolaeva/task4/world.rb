Dir[File.expand_path('./../*.rb', __FILE__)].each { |f| require(f) }

Class World
  attr_accessor :rows, :columns, :cells, :cell_board
  def initialize(rows = 3, columns = 3)
    @rows = rows
    @cols = columns
    @cells = []
    @cell_board = Array.new(rows) do |row|
                    Array.new(columns) do |column|
                      Cells.new(column, row)
                    end
                  end
    cell_board.each do |row|
      row.each do |element|
        if element.is_a?(Cell)
          cells << element
        end
      end
    end
  end

  def live_cells
    cells.select { |cell| cell.alive }
  end

  def dead_cells
    cells.select { |cell| cell.alive == false}
  end

  def live_neighbours_around_cells(cell)
    live_neighbours = []
    if cell.y > 0 and cell.x < (columns - 1)
      next = self.cell_board[cell.y - 1][cell.x + 1]
      live_neighbours << next if next.alive?
    end
    if cell.y < (rows - 1) and cell.x < (columns - 1)
      next = self.cell_board[cell.y + 1][cell.x + 1]
      live_neighbours << next if next.alive?
    end
    if cell.y < (rows - 1) and cell.x > 0
      next = self.cell_board[cell.y + 1][cell.x - 1]
      live_neighbours << next if next.alive?
    end
    if cell.y > 0 and cell.x > 0
      next = self.cell_board[cell.y - 1][cell.x - 1]
      live_neighbours << next if next.alive?
    end
    if cell.y > 0
      next = self.cell_board[cell.y - 1][cell.x]
      live_neighbours << next if next.alive?
    end
    if cell.x < (columns - 1)
     next = self.cell_board[cell.y][cell.x + 1]
     live_neighbours << next if next.alive?
    end
    if cell.y < (rows - 1)
      next = self.cell_board[cell.y + 1][cell.x]
      live_neighbours << next if next.alive?
    end
    if cell.x > 0
      next = self.cell_board[cell.y][cell.x - 1]
      live_neighbours << next if next.alive?
    end
    live_neighbours
  end

  def random_populate
    cells.each do |cell|
      cell.alive = [true, false].sample
    end
  end
