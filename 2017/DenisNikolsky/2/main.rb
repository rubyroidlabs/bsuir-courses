require_relative 'parser'

parser = Parser.new
link = 'https://genius.com/artists/songs?for_artist_page=117146&id=King-of-the-dot&page=1&pagination=true'
parser.parse_site(link)
artist_name = ENV['NAME']
if artist_name.nil?
parser.parse_all_battles
else
  parser.parse_one(artist_name)
end
