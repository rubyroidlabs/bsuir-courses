require 'mechanize'

uri = 'https://genius.com/artists/King-of-the-dot'

agent = Mechanize.new

page = agent.get(uri).links_with(:href => %r{\w+-lyrics} )[0].click
#  page = link.click
  puts page.uri
  puts page.title
  text = page.css('.lyrics').text.strip
  round = text.scan(%r{\[Round \d: \w+\]})
  lyrics = text.split(%r{\s*\[Round \d: \w+\]\s*})
  lyrics.shift # first element = "" (empty string)
  (0...round.count).each do |i|
    puts round[i]
    p lyrics[i]
  end

