require 'mechanize'

class Parser
  attr_accessor :battle_links

  def initialize
    @battle_links = {}
    @agent = Mechanize.new
    @agent.user_agent_alias = 'Mac Safari'
  end

  def parse_site(link)
    page = @agent.get(link)
    loop do
      page.links.each do |battle|
        next unless battle.text.to_s['vs']
        key = enter_battle_title(battle)
        @battle_links[key] = battle.href
      end
      next_page = page.links_with(class: 'next_page')[0]
      break if next_page.nil?
      puts '--next page--'
      page = next_page.click
    end
  end

  def parse_all_battles(criteria = /\w/)
    @battle_links.each do |key, value|
      parse_battle(key, value, criteria)
    end
  end

  def parse_one(artist_name, criteria = /\w/)
    win = 0
    lose = 0
    @battle_links.each do |key, value|
      next unless key.include?(artist_name)
      result = parse_battle(key, value, criteria)
      unless result.nil?
        if result.include?(artist_name)
          win += 1
        else
          lose += 1
        end
      end
    end
    puts ''
    puts "#{artist_name} wins #{win} times, loses #{lose} times"
  end

  def parse_battle(key, value, criteria)
    page = @agent.get(value)
    texts = page.search('.lyrics')[0].text.strip
    first = texts.scan(/Round 1:.+/)[0]
    members = parse_members(key, first)
    texts = texts.split(/Round.+/)
    texts.shift
    first_mc_letters = count_letters(texts, 0, criteria)
    second_mc_letters = count_letters(texts, 1, criteria)
    first_mc = { name: members[0], letters: first_mc_letters }
    second_mc = { name: members[1], letters: second_mc_letters }
    puts ''
    find_winner(first_mc, second_mc, key, value)
  end

  def parse_members(key, first)
    members = key.split('vs')
    members[1] = members[1].delete('.').strip
    unless first.nil?
      if first.include?(members[1])
        t = members[0]
        members[0] = members[1]
        members[1] = t
      end
    end
    members
  end

  def enter_battle_title(battle)
    key = battle.text.strip
    index = key.index('(')
    key = key.slice(0...index) unless index.nil?
    puts key
    key
  end

  def count_letters(texts, speech, criteria)
    letters = 0
    round = texts.size / 2
    round.times do
      if texts[speech].nil?
        letters = 0
      else
        letters += texts[speech].scan(criteria).size
      end
      speech += 2
    end
    letters
  end

  def find_winner(first_mc, second_mc, key, value)
    first_letters = first_mc[:letters]
    second_letters = second_mc[:letters]
    first_name = first_mc[:name]
    second_name = second_mc[:name]
    puts "#{key} - #{value}"
    puts "#{first_name} - #{first_letters}"
    puts "#{second_name} - #{second_letters}"
    if first_letters > second_letters
      str = "#{first_name} wins!"
      puts str
      str
    elsif first_letters < second_letters
      str = "#{second_name} wins!"
      puts str
      str
    else
      puts "can't find winner"
    end
  end
end
