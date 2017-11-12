require_relative 'imdb_parser'
require_relative 'wiki_list_parser'
require_relative 'newnownext_parser'
require_relative 'dailynews_parser'
require 'json'

celeb = {}
link = 'http://www.imdb.com/list/ls072706884/'
imdb_parser = ImdbParser.new
celeb = imdb_parser.parse_site(link, celeb)

link = 'http://www.imdb.com/list/ls059456655/'
celeb = imdb_parser.parse_site(link, celeb)

wiki_parser = WikiParser.new
link = 'https://en.wikipedia.org/wiki/List_of_gay,_lesbian_or_bisexual_people'
celeb = wiki_parser.parse_wiki(link, celeb)

nnn_parser = NNNParser.new
link = 'http://www.newnownext.com/gay-celebrities-coming-out-2017/10/2017/'
celeb = nnn_parser.parse_site(link, celeb)

parser = DailyNewsParser.new
link = 'http://www.nydailynews.com/entertainment/gossip/celebrities-disclose-sexual-orientation-gender-identity-gallery-1.73963?pmSlide=1.3598149'
celeb = parser.parse_site(link, celeb)

celeb = celeb.to_json
File.open('celebrities', 'w') { |file| file.write celeb }
