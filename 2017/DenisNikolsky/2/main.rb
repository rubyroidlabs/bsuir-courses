require_relative 'parser'

parser = Parser.new
link = 'https://genius.com/artists/songs?for_artist_page=117146&id=King-of-the-dot&page=1&pagination=true'
parser.parse_site(link)
artist = ENV['NAME']
criteria = ENV['CRITERIA']
if artist.nil?
  criteria.nil? ? parser.parse_all_battles : parser.parse_all_battles(criteria)
else
  criteria.nil? ? parser.parse_one(artist) : parser.parse_one(artist, criteria)
end
