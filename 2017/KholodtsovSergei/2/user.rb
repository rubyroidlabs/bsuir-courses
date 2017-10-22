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
      print name + ' ' + '-'
      @text = @text.delete('\n')
      puts @points = @text.downcase.scan(/[a-zA-Z]/).size
    else
      print name + ' ' + '-'
      @text = @text.delete('\n')
      puts @points = @text.downcase.scan(criteria).size
    end
  end
end
