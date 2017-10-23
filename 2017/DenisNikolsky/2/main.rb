require 'mechanize'

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
    index = texts.index(participants[1])
    if !index.nil? && index < 10
      t = participants[0]
      participants[0] = participants[1]
      participants[1] = t
    end
    texts = texts.split(/Round.+/)
    texts.shift
    first_mc_letters = count_letters(texts, 0)
    scnd_mc_letters = count_letters(texts, 1)
    first_mc = {name: participants[0], battle: key, letters: first_mc_letters}
    second_mc = {name: participants[1], battle: key, letters: scnd_mc_letters}
    find_winner(first_mc, second_mc, value)
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

def find_winner(first_mc, second_mc, value)
  first_letters = first_mc[:letters]
  second_letters = second_mc[:letters]
  first_name = first_mc[:name]
  second_name = second_mc[:name]
  puts "#{first_mc[:battle]} - #{value}"
  puts "#{first_name} - #{first_letters}"
  puts "#{second_name} - #{second_letters}"
  if first_letters > second_letters
    puts "#{first_name} wins!"
  elsif first_letters < second_letters
    puts "#{second_name} wins!"
  elsif first_letters && second_letters
    puts "can't parse battle"
  end
  puts ''
end

agent = Mechanize.new
agent.user_agent_alias = 'Mac Safari'
link = 'https://genius.com/artists/songs?for_artist_page=117146&id=King-of-the-dot&page=1&pagination=true'
page = agent.get(link)
links = parse_site(page)
parse_battle(links, agent)
