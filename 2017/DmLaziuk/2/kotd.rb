require 'mechanize'

def parse(parse_page)
  parse_page.links_with(:href => %r{\w+-lyrics} ).each do |link|
    page = link.click
    count = Hash.new
    text = page.css('.lyrics').text.strip
    text.gsub!(%r{\[\?\]}, '')
    round = text.scan(%r{\[.*?\]\n})
    lyrics = text.split(%r{\s*\[.*?\]\s*})
    lyrics.shift # first element = "" (empty string)
    (0...round.count).each do |i|
      performer = round[i]
      performer[%r{\[}] = ''
      performer[%r{\]}] = ''
      performer.strip!
      performer.gsub!(%r{Round\s\d\s?[:|\u2013]*\s*}, '')
      #split(%r{:|\u2013})[1].scan(/\w+/)[0]
      word_count = lyrics[i].scan(%r{\S+}).count if lyrics[i]
      if count[performer]
        count[performer] += word_count
      else
        count[performer] = word_count
      end
    end
    if count.size > 1
      puts count.keys[0].to_s + ' vs ' + count.keys[1].to_s + ' - ' + page.uri.to_s
      count.each { |key, value| puts key.to_s + ' - ' + value.to_s }
      max = count.values[0] > count.values[1] ? 0 : 1
      puts count.keys[max].to_s + ' WINS!'
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
