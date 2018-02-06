class Statistic
  attr_accessor :nickname, :victories, :losses

  def initialize(name)
    @nickname = name
    @victories = 0
    @losses = 0
  end
end
