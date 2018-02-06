require_relative 'web_parser'

url = 'https://genius.com/artists/King-of-the-dot'

WebParser.new(url, ENV['NAME'], ENV['CRITERIA']).start
