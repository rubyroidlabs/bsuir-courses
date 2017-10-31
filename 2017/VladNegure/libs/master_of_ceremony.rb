class MasterOfCeremony # aka MC
  attr_reader :name, :winnings, :losses

  def initialize(name)
    @name = name.capitalize
    @winnings = 0
    @losses = 0
  end

  def won?(winner)
    if winner.casecmp(name).zero?
      win
      true
    elsif !winner.casecmp('tie').zero?
      lose
      false
    end
  end

  private

  def win
    @winnings += 1
  end

  def lose
    @losses += 1
  end
end
