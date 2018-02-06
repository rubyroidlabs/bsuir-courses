class Battler
  attr_accessor :name, :text, :wins, :points

  def initialize(name, text)
    @name = name
    @text = text
    @wins = 0
  end

  def found_points(criteria)
    @text = @text.delete('\n')
    @points = if criteria
                @text.downcase.scan(criteria).size
              else
                @text.downcase.scan(/[a-zA-Z]/).size
              end
    puts "#{@name} - #{@points}"
  end
end
