require 'mechanize'

def parse(parse_page)
  parse_page.links_with(:href => %r{\w+-lyrics} ).each do |link|
    page = link.click
    count = Hash.new
    text = page.css('.lyrics').text.strip
    text.gsub!(%r{\[\?\]}, '')
    text.gsub!(%r{\[\.\.\.\]}, '')
    text.gsub!(%r{\[…\]}, '')
    text.gsub!(%r{\[\*.*?\*\]}, '')
    round = text.scan(%r{\[.*?\]})
    lyrics = text.split(%r{\[.*?\]})
    lyrics.shift # first element = "" (empty string)
    (0...round.count).each do |i|
      performer = round[i]
      performer.gsub!(%r{\[}, '')
      performer.gsub!(%r{\]}, '')
      performer.strip!
      performer.gsub!(%r{Round\s\d\s?[:|\-|\u2013]*\s*}, '')
      word_count = lyrics[i].scan(%r{\S+}).count if lyrics[i]
      if count[performer]
        count[performer] += word_count if word_count
      else
        count[performer] = word_count if word_count
      end
    end
    if count.size > 1
      title = page.title
      title.gsub!('King of the Dot –', '')
      title.gsub!('Lyrics | Genius Lyrics', '')
      puts title.strip + ' - ' + page.uri.to_s
      winner = count.keys[0]
      winner_value = count.values[0]
      count.each do |key, value|
        puts key.to_s + ' - ' + value.to_s
        if value > winner_value
          winner = key
          winner_value = value
        end
      end
      puts winner.to_s + ' WINS!'
      puts
    end
  end
end

uri = 'https://genius.com/artists/songs?for_artist_page=117146&id=King-of-the-dot&page=1&pagination=true'
agent = Mechanize.new
page = agent.get(uri)
parse(page)
next_page = page.links_with(:class => 'next_page')[0]
while next_page
  page = next_page.click
  parse(page)
  next_page = page.links_with(:class => 'next_page')[0]
end
