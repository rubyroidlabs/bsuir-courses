class User
  attr_accessor :name, :text, :wins, :points

  def initialize(name, text)
    @name = name
    @text = text
    @wins = 0
    @points = 0
  end

  def found_criteria(criteria)
    if criteria.nil?
      name += '-'
      @text = @text.delete('\n')
      @points = @text.downcase.scan(/[a-zA-Z]/).size
      puts name + @points.to_s
    else
      name += '-'
      @text = @text.delete('\n')
      @points = @text.downcase.scan(criteria).size
      puts name + @points.to_s
    end
  end
end
