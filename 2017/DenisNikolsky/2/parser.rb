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

  def parse_battle
    @battle_links.each do |key, value|
      page = @agent.get(value)
      participants = key.split('vs')
      participants[1] = participants[1].delete('.').strip
      texts = page.search('.lyrics')[0].text.strip
      first = texts.scan(/Round 1:.+/)[0]
      unless first.nil?
        if first.include?(participants[1])
          t = participants[0]
          participants[0] = participants[1]
          participants[1] = t
        end
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
    else
      puts "can't find winner"
    end
    puts ''
  end
end