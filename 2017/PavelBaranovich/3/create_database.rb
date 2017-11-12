require_relative 'imdb_parser'
require_relative 'database'

parser = IMDbParser.new
parser.parse

database = Database.new
database.info = parser.names
database.upload_to_file
