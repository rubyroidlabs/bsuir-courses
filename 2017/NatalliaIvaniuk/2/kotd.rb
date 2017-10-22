require 'mechanize'
require 'json'
require 'date'

name = ENV['NAME']
crit = ENV['CRITERIA']
agent = Mechanize.new
page = agent.get('https://genius.com/artists/songs?for_artist_page=117146&id=King-of-the-dot')
href_reg_exp = %r{https://genius.com/King-of-the-dot-.+-lyrics}
song_links = page.links_with(href: /#{href_reg_exp}/)
songs = []
song_links.each do |link|
  song = link.click
  href = link.href
  title = song.search('.header_with_cover_art-primary_info-title').text
  text = song.search('.lyrics').text
  songs << { href: href, title: title, text: text }
end

wins = 0
loses = 0
n = 0
artist1text = []
artist2text = []
a1l = 0
a2l = 0

20.times do
  artist1 = songs[n][:title].split(/[vV]s.?/)[0].strip
  artist2 = songs[n][:title].split(/[vV]s.?/)[1].strip
  battle_text = songs[n][:text].split(/\[Round [123].+\]/)
  battle_text.each_with_index do |val, index|
    if index.even?
      artist2text << val
    else
      artist1text << val
    end
  end
  if crit.empty?
    artist1text.each { |x| a1l += x.scan(/\w/).size }
    artist2text.each { |x| a2l += x.scan(/\w/).size }
  else
    artist1text.each { |x| a1l += x.scan(/#{crit}/).size }
    artist2text.each { |x| a2l += x.scan(/#{crit}/).size }
  end
  if songs[n][:title].include? name
    puts songs[n][:title] + ' - ' + songs[n][:href]
    puts artist1 + ' - ' + a1l.to_s
    puts artist2 + ' - ' + a2l.to_s
    if a1l > a2l
      puts artist1 + ' WINS!'
      if artist1.include? name
        wins += 1
      else loses += 1
      end
    elsif a1l < a2l
      puts artist2 + ' WINS!'
      if artist2.include? name
        wins += 1
      else loses += 1
      end
    else
      puts 'DRAW!'
    end
    puts '*' * 100
  end
  n += 1
end
puts name + ' wins ' + wins.to_s + ' times, loses ' + loses.to_s + ' times.'
