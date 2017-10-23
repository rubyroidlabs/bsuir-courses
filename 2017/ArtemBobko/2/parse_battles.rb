require 'rubygems'
require 'mechanize'
require 'json'

class PARSE_BATTLES
  def process_text(text)
    text = text.split(/\[Round [123].+\]\n/)
    text.shift
    text = text.map { |i| i.gsub(/\s+/, "") }
  end

  def count(text, i)
    sum = 0
    while !text[i].nil?
      sum += text[i].length
      i += 2
    end
    sum
  end

  def output(text, rappers)
    print "#{rappers[0]} - "
    symbols1 = count(text, 0)
    print "#{symbols1}\n"
    rappers[1][0] = ''
    print "#{rappers[1]} - "
    symbols2 = count(text, 1)
    print "#{symbols2}\n"
    if symbols1 > symbols2
      print "#{rappers[0]} WINS!\n\n"
    elsif symbols1 < symbols2
      print "#{rappers[1]} WINS!\n\n"
    elsif symbols1 == symbols2
      print "DRAW!"
    end
  end

  def parse_battles
    agent = Mechanize.new
    next_page = 1
    while !next_page.nil?
      songs = JSON.parse(agent.get("https://genius.com/api/artists/117146/songs?page=#{next_page}").content)
      next_page = songs['response']['next_page']
      songs = songs['response']['songs'].uniq
      songs.map do |song|
        song_page = agent.get(song['url'])
        text = song_page.search('.lyrics p').text
        rappers = song['title'].split(/vs/)
        text = process_text(text)
        puts song['title'] + ' - ' + song['url']
        output(text, rappers)
      end
    end
  end
end
