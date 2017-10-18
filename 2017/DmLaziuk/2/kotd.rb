require 'mechanize'

uri = 'https://genius.com/artists/King-of-the-dot'

agent = Mechanize.new

agent.get(uri) do |parse_page|
  parse_page.links_with(:href => %r{\w+-lyrics} ).each do |link|
    page = link.click
    pp link
#    pp page
    count = Hash.new
    text = page.css('.lyrics').text.strip
    round = text.scan(%r{\[Round \d+: \w+\s*\w*\]})
    p round
    lyrics = text.split(%r{\s*\[Round \d: \w+\s*\w*\]\s*})
    lyrics.shift # first element = "" (empty string)
    (0...round.count).each do |i|
      key = round[i].split(':')[1].scan(/\w+/)[0]
      p key
      value = lyrics[i].scan(/\S+/).count
      p value
      if count[key]
        count[key] += value
      else
        count[key] = value
      end
      # puts round[i].split(':')[0].scan(/\d+/)
      # puts round[i].split(':')[1].scan(/\w+/)
      # puts lyrics[i].scan(/\S+/).count
    end
    puts count.keys[0].to_s + ' vs ' + count.keys[1].to_s + ' - ' + page.uri.to_s
    count.each { |key, value| puts key.to_s + ' - ' + value.to_s }
    max = count.values[0] > count.values[1] ? 0 : 1
    puts count.keys[max].to_s + ' WINS!'
    puts
    end
end

