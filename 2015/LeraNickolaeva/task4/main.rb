Dir[File.expand_path('./../*.rb', __FILE__)].each { |f| require(f) }
require 'gosu'

Class Window
  def initialize(height=1800, width=900)
    @height = height
    @width = width
    super height, width, false
    self.caption = 'Game of Life'
    @background = Gosu::Color.new(0xffdedede)
    @alive = Gosu::Color.new(0xff121212)
    @dead = Gosu::Color.new(0xffededed)
    @rows = height / 10
    @columns = width / 10
    @world = World.new(@columns, @rows)
    @game = Game.new(@world)
    @r_h = height / @rows
    @c_w = width / @columns
    @game.world.randomly_populate
    @generation = 0
  end

  def update
    @game.tick!
    @generation += 1
    puts "Generation No: #{@generation}"
  end

  def draw
    draw_background
    @game.world.cells.each do |cell|
      if cell.alive?
        draw_quad(cell.x * @c_w, cell.y * @r_h, @alive,
                  cell.x * @c_w + (@c_w - 1), cell.y * @r_h, @alive,
                  cell.x * @c_w + (@c_w - 1), cell.y * @r_h + (@r_h - 1), @alive,
                  cell.x * @c_w, cell.y * @r_h + (@r_h - 1), @alive)
      else
        draw_quad(cell.x * @c_w, cell.y * @r_h, @dead,
                  cell.x * @c_w + (@c_w - 1), cell.y * @r_h, @dead,
                  cell.x * @c_w + (@c_w - 1), cell.y * @r_h + (@r_h - 1), @dead,
                  cell.x * @c_w, cell.y * @r_h + (@r_h - 1), @dead)
      end
    end
  end

  def button_down(id)
    case id
    when Gosu::KbSpace
      @game.world.random_populate
    when Gosu::KbEscape
      close
    end
  end

  def needs_cursor?
    true
  end

  def draw_background
    draw_quad(0, 0, @background,
              width, 0, @background,
              width, height, @background,
              0, height, @background)
  end

Window.new.show
