Dir[File.expand_path('./../*.rb', __FILE__)].each { |f| require(f) }

Class Cells
  attr_accessor :alive, :x, :y

  def initialize(x = 0, y = 0)
    @x = x
    @y = y
    @alive = false
  end

  def alive?; alive; end
  def dead?; !alive; end

  def die!
    @alive = false
  end

  def revive!
    @alive = true
  end
