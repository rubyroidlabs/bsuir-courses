require 'mechanize'
require 'date'
require 'json'
agent = Mechanize.new
ALL_SONGS_LINK = 'Show all songs by King of the Dot'.freeze
VS = 'vs'.freeze
def parse_song(agent, href)
  song = agent.get(href)
  title = song.at('.header_with_cover_art-primary_info-title').text
  split_title = title.split(/vs/)
  first_singer = split_title.first.strip
  second_singer = split_title.last.strip
  rounds = song.at('.lyrics').text.split(/\[+[\w\s\:]+\]+/)
  first = rounds[1..6].select.with_index { |_words, index| index.odd? }
  second = rounds[1..6].select.with_index { |_words, index| index.even? }
  first_letters = 0
  first.each { |element| first_letters += element.scan(/\w+/).join.size }
  second_letters = 0
  second.each { |element| second_letters += element.scan(/\w+/).join.size }
  result = "\n#{title} - #{href}"\
           "\n#{first_singer} #{first_letters}"\
           "\n#{second_singer} #{second_letters}\n"
  result += if first_letters > second_letters
              "#{first_singer} WINS"
            elsif first_letters < second_letters
              "#{second_singer} WINS"
            else
              'TIE'
            end
  puts result
end
page = agent.get('https://genius.com/api/artists/117146/'\
  'songs?page=1&sort=popularity')
require 'json'
result = []
songs = JSON.parse(page.body)['response']['songs']
next_page = JSON.parse(page.body)['response']['next_page']
result.concat(songs.each { |song| song.select! { |k| k.to_s == 'url' } })
loop do
  page = agent.get('https://genius.com/api/artists/117146/songs?'\
                    "page=#{next_page}&sort=popularity")
  next_page = JSON.parse(page.body)['response']['next_page']
  result.concat(songs.each { |song| song.select! { |k| k.to_s == 'url' } })
  break unless next_page
end
result.each { |l| parse_song(agent, l['url']) }
