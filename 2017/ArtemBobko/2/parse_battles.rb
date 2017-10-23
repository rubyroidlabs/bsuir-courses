require 'rubygems'
require 'mechanize'
require 'json'

class ParseBattles
  def process_text(text)
    text = text.split(/\[Round [123].+\]\n/)
    text.shift
    text.map { |i| i.gsub(/\s+/, '') }
  end

  def count(text, i)
    sum = 0
    until text[i].nil?
      sum += text[i].length
      i += 2
    end
    sum
  end

  def output(text, rappers)
    if text.nil? || rappers[1].nil?
      puts 'Error'
      return
    end
    print "#{rappers[0]} - "
    symbols1 = count(text, 0)
    puts symbols1
    rappers[1][0] = ''
    print "#{rappers[1]} - "
    symbols2 = count(text, 1)
    puts symbols2
    if symbols1 > symbols2
      puts "#{rappers[0]} WINS!"
    elsif symbols1 < symbols2
      puts "#{rappers[1]} WINS!"
    elsif symbols1 == symbols2
      puts 'DRAW!'
    end
    puts
  end

  def parse_battles
    agent = Mechanize.new
    next_page = 1
    until next_page.nil?
      request = 'https://genius.com/api/artists/117146/songs?page='
      songs = agent.get(request + next_page.to_s).content
      songs = JSON.parse(songs)
      next_page = songs['response']['next_page']
      songs = songs['response']['songs'].uniq
      songs.map do |song|
        song_page = agent.get(song['url'])
        text = song_page.search('.lyrics p').text
        rappers = song['title'].split(/[Vv]s/)
        text = process_text(text)
        puts song['title'] + ' - ' + song['url']
        output(text, rappers)
      end
    end
  end
end
