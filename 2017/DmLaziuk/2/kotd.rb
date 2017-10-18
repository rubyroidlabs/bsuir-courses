require 'mechanize'

uri = 'https://genius.com/artists/King-of-the-dot'

agent = Mechanize.new

agent.get(uri) do |parse_page|
  parse_page.links_with(:href => %r{\w+-lyrics} ).each do |link|
    page = link.click
    count = Hash.new
    text = page.css('.lyrics').text.strip
    round = text.scan(%r{\[Round.*?\]})
    lyrics = text.split(%r{\s*\[Round.*?\]\s*})
    lyrics.shift # first element = "" (empty string)
    (0...round.count).each do |i|
      performer = round[i].split(%r{:|\u2013})[1].scan(/\w+/)[0]
      word_count = lyrics[i].scan(%r{\S+}).count
      if count[performer]
        count[performer] += word_count
      else
        count[performer] = word_count
      end
    end
    puts count.keys[0].to_s + ' vs ' + count.keys[1].to_s + ' - ' + page.uri.to_s
    count.each { |key, value| puts key.to_s + ' - ' + value.to_s }
    max = count.values[0] > count.values[1] ? 0 : 1
    puts count.keys[max].to_s + ' WINS!'
    puts
    end
end

