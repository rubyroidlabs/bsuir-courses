require_relative '../parse/imdb'
require_relative '../parse/newnownext'
require_relative '../parse/wiki'

# Parsing hashes from site parsers into file
class Write
  attr_reader :info

  def initialize
    @imdb_info = IMDBParser.new.names
    @nnn_info = NewNowNextParser.new.names
    @wiki_info = WikiParser.new.names
    @info = @imdb_info.concat(@nnn_info).concat(@wiki_info).uniq
    write
  end

  private

  def write
    file = File.open('data/database.txt', 'w+')
    file.puts(@info)
    file.close
  end
end
