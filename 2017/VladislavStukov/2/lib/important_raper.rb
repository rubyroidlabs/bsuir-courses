class ImportantRaper
  attr_reader :name

  def initialize(name)
    @name = name
    @wins = 0
    @loses = 0
  end

  def win
    @wins += 1
  end

  def lose
    @loses += 1
  end

  def result
    "#{@name} wins #{@wins} times, loses #{@loses} times."
  end
end
