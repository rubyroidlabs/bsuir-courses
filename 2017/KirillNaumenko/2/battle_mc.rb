# MC Constructor
class BattleMc
  attr_accessor :name, :text, :flank

  def initialize(name=nil, text=nil, flank=nil)
    @name = name
    @text = text
    @flank = flank
  end

  def letters_count
    text.inject(0) { |c, w| c+= w.length }
  end
end
