class Battler
  attr_accessor :name,
                :points,
                :count_of_wins,
                :count_of_defeat
  def initialize
    @name = ''
    @points = 0
    @count_of_wins = 0
    @count_of_defeat = 0
   end
+end