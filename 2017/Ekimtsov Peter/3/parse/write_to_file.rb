require_relative '../parse/imdb_parser'

# Parsing hashes from site parsers into file
class Write
  def initialize
    @imdb_parser = IMDBParser.new
  end

  def parse
    names_orientations = @imdb_parser.names_orientation
    write(names_orientations)
  end

  def write(pair)
    file = File.open("../data/database.txt", "a+")
    file.puts(pair)
    file.close
  end
end

test = Write.new
test.parse