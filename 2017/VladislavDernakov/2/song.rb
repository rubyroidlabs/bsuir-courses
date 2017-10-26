class Song
  attr_reader :lyrics, :name, :link
  def initialize(name, link, lyrics)
    @name = name
    @link = link
    @lyrics = lyrics
  end
end
