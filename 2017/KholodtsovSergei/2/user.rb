class User
  attr_accessor :name, :text, :wins, :points

  def initialize(name, text)
    @name = name
    @text = text
    @wins = 0
    @points = 0
  end

  def found_criteria(criteria)
    @name += '-'
    @text = @text.delete('\n')
    if criteria
      @points = @text.downcase.scan(/[a-zA-Z]/).size
    else
      @points = @text.downcase.scan(criteria).size
    end
    puts @name + @points.to_s
  end
end
