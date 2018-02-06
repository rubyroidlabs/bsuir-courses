require_relative 'PRIDE_parser'
require_relative 'IMDB_parser'
require_relative 'GayStarNews_parser'
require 'json'

celebrities = {}

imdb_data = IMDbParser.new('http://www.imdb.com/list/ls072706884/')
imdb_data.parse_page
celebrities = imdb_data.copy

pride_data2017 = PrideParser.new('https://www.pride.com/comingout/2017/10/29/35-notable-people-who-came-out-2017-so-far')
pride_data2017.parse_page
temp = pride_data2017.copy
celebrities.merge!(temp)

pride_data2016 = PrideParser.new('https://www.pride.com/women/2016/12/22/21-female-celebrities-who-came-out-2016')
pride_data2016.parse_page
temp = pride_data2016.copy
celebrities.merge!(temp)

gaystarnews_data = GayStarNewsParser.new('https://www.gaystarnews.com/article/22-celebrities-who-came-out-and-changed-the-world-in-2015/')
gaystarnews_data.parse_page
temp = gaystarnews_data.copy
celebrities.merge!(temp)

celebrities = celebrities.to_json
File.open('Data.txt', 'w') do |file|
  file.write celebrities
end
