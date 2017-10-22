require 'mechanize'

class Artist
  attr_accessor :name, :battle

  def initialize(name = 'Anon', rivals = 'xxx', letters = 0)
    @name = name
    @battle = {}
    @battle[rivals] = letters
  end
end

def parse_site(page)
  links = {}
  loop do
    page.links.each do |battle|
      next unless battle.text.to_s['vs']
      key = enter_battle_title(battle)
      links[key] = battle.href
    end
    next_page = page.links_with(class: 'next_page')[0]
    break if next_page.nil?
    puts '--next page--'
    page = next_page.click
  end
  links
end

def parse_battle(links, agent)
  links.each do |key, value|
    page = agent.get(value)
    participants = key.split('vs')
    participants[1] = participants[1].delete('.').strip
    texts = page.search('.lyrics')[0].text.strip
    texts = texts.split(/Round.+/)
    texts.shift
    first_mc_letters = count_letters(texts, 0)
    second_mc_letters = count_letters(texts, 1)
    first_mc = Artist.new(participants[0], key, first_mc_letters)
    second_mc = Artist.new(participants[1], key, second_mc_letters)
    find_winner(first_mc, second_mc, key, value)
  end
end

def enter_battle_title(battle)
  key = battle.text.strip
  index = key.index('(')
  key = key.slice(0...index) unless index.nil?
  puts key
  key
end

def count_letters(texts, speech)
  letters = 0
  round = texts.size / 2
  round.times do
    if texts[speech].nil?
      letters = 0
    else
      letters += texts[speech].scan(/\w/).size
    end
    speech += 2
  end
  letters
end

def find_winner(first_mc, second_mc, key, value)
  first_mc_letters = first_mc.battle[key]
  second_mc_letters = second_mc.battle[key]
  puts "#{key} - #{value}"
  puts "#{first_mc.name} - #{first_mc_letters}"
  puts "#{second_mc.name} - #{second_mc_letters}"
  if first_mc_letters > second_mc_letters
    puts "#{first_mc.name} wins!"
  elsif first_mc_letters < second_mc_letters
    puts "#{second_mc.name} wins!"
  elsif first_mc_letters.zero? && second_mc_letters.zero?
    puts "can't parse battle"
  end
end

agent = Mechanize.new
agent.user_agent_alias = 'Mac Safari'
link = 'https://genius.com/artists/songs?for_artist_page=117146&id=King-of-the-dot&page=1&pagination=true'
page = agent.get(link)
links = parse_site(page)

parse_battle(links, agent)
