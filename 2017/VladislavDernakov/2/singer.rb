class Singer
  attr_reader :name
  attr_accessor :song
  def initialize(name)
    @name = name
    @song = ''
  end
end
