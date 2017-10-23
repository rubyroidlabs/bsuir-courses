class BattleMc
  attr_accessor :name, :text, :flank

  def initialize(name = nil, text = nil, flank = nil)
    @name = name
    @text = text
    @flank = flank
  end

  def letters_count
    text.inject(0) do |c, w|
      c += w.length
      c
    end
  end
end
