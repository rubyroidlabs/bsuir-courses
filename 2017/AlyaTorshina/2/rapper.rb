class Rapper
  attr_accessor :name, :count, :won, :lost

  def initialize(name)
    @name = name
    @count = 0
    @won = 0
    @lost = 0
  end
end
