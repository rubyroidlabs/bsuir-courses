require_relative 'parser'

parser = Parser.new
link = 'https://genius.com/artists/songs?for_artist_page=117146&id=King-of-the-dot&page=1&pagination=true'
parser.parse_site(link)
parser.parse_battle
