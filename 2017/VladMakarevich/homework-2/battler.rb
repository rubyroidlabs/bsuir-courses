class Battler
  attr_accessor :name,
                :points,
                :count_of_wins,
                :count_of_defeat
  # In methods, the + = construct is used,
  # so there is a need to set to zero these variables when creating an object
  def initialize
    @name = ''
    @points = 0
    @count_of_wins = 0
    @count_of_defeat = 0
  end
end
