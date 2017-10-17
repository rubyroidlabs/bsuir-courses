require 'mechanize'

uri = 'https://genius.com/artists/King-of-the-dot'

agent = Mechanize.new

page = agent.get(uri).links_with(:href => %r{lyrics} )[0].click
#  page = link.click
  puts page.uri
  puts page.title
  puts page.css('.lyrics').text

