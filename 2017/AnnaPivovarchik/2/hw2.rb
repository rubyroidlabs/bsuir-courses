require 'mechanize'
require 'date'
require 'json'

def parse_song(agent, href)
  song = agent.get(href)
  title = song.at('.header_with_cover_art-primary_info-title').text
  splitted_title = title.split(/vs/)
  first_singer = splitted_title.first.strip
  second_singer = splitted_title.last.strip
  rounds = song.at('.lyrics').text.split(/\[+[\w\s\:]+\]+/)
  first_mc = rounds[1..6].select.with_index { |_words, index| index.odd? }
  second_mc = rounds[1..6].select.with_index { |_words, index| index.even? }
  first_letters = count_letters(first_mc)
  second_letters = count_letters(second_mc)
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

def count_letters(rounds)
  counter = 0
  rounds.each { |element| counter += element.scan(/\w+/).join.size }
  counter
end

def parse_body(page)
  JSON.parse(page.body)['response']
end

def parse_urls(songs)
  songs.each { |song| song.select! { |k| k.to_s == 'url' } }
end

ALL_SONGS_LINK = 'Show all songs by King of the Dot'.freeze
VS = 'vs'.freeze

agent = Mechanize.new

page = agent.get('https://genius.com/api/artists/117146/'\
  'songs?page=1&sort=popularity')
result = []
parsed_body = parse_body(page)
songs = parsed_body['songs']
next_page = parsed_body['next_page']
result.concat(parse_urls(songs))
loop do
  page = agent.get('https://genius.com/api/artists/117146/songs?'\
                    "page=#{next_page}&sort=popularity")
  songs = parse_body(page)['songs']
  next_page = parse_body(page)['next_page']
  result.concat(parse_urls(songs))
  break unless next_page
end
result.each { |l| parse_song(agent, l['url']) }
