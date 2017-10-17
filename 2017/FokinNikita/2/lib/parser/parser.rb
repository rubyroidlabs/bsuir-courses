require 'mechanize'

agent = Mechanize.new
page = agent.get('https://genius.com/artists/King-of-the-dot')
