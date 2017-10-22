class User
  attr_accessor :name, :text, :wins, :points

  def initialize(name, text)
    @name = name
    @text = text
    @wins = 0
    @points = 0
  end

  def found_criteria(criteria)
    @text = @text.delete('\n')
    @points = if criteria
                @text.downcase.scan(criteria).size
              else
                @text.downcase.scan(/[a-zA-Z]/).size
              end
    puts @name + '-' + @points.to_s
  end
end
