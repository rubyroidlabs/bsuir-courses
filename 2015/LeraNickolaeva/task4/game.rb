Dir[File.expand_path('./../*.rb', __FILE__)].each { |f| require(f) }

Class Game
  attr_accessor :world

  def initialize(world = World.new, seeds = [])
    @world = world
    seeds.each do |seed|
      world.cell_board[seed[0]seed[1]].alive = true
    end
  end

  def tick!
    @world.cells.each do |cell|
      neighbour_count = self.world.live_neighbours_around_cell(cell).count
      if cell.alive? && neighbour_count < 2
        next_round_dead_cells << cell
      end
      if cell.alive? && ([2, 3].include? neighbour_count)
        next_round_live_cells << cell
      end
      if cell.alive? && neighbour_count > 3
        next_round_dead_cells << cell
      end
      if cell.dead? && neighbour_count == 3
        next_round_live_cells << cell
      end
    end

    next_round_live_cells.each do |cell|
      cell.revive!
    end
    next_round_dead_cells.each do |cell|
      cell.die!
    end
  end
