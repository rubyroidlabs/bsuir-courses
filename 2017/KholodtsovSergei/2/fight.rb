require_relative('battler')
require 'mechanize'
require 'terminal-size'
require 'date'
require 'json'

class Fight
  attr_accessor :left_battler, :right_battler, :battle, :vip_battler
  HOME_LINK = 'https://genius.com/artists/songs?for_artist_page=117146'

  def start(name, criteria)
    name_for_parse = found_marks(name)
    page_list = found_page_list(name_for_parse)
    found_battlers(page_list, criteria)
    if @vip_battler
      print "#{@vip_battler.name} wins #{@vip_battler.wins} "
      loses = page_list.length - @vip_battler.wins
      puts "times, loses #{loses} times."
    end
  end

  def found_marks(name)
    if name
      @vip_battler = Battler.new(name, '')
      name.downcase.sub(' ', '-')
    else
      'lyrics'
    end
  end

  def found_page_list(name)
    agent = Mechanize.new
    page = agent.get HOME_LINK
    review_page = page.links_with(href: /#{name}/)
    hidden_page = page.links_with(href: /pagination=true/)
    hidden_page.delete(hidden_page.last)
    hidden_page.each do |item|
      review_page += item.click.links_with(href: /#{name}/)
    end
    review_page
  end

  def found_battlers(page_list, criteria)
    page_list.each do |item|
      found_battle(item)
      found_text(item)
      @left_battler.found_points(criteria)
      @right_battler.found_points(criteria)
      found_winner
    end
  end

  def found_battle(item)
    @battle = item.text.split(' ').join(' ').delete('["').split(' (').shift
    @battle = @battle.split(/vs.?/i)
    @left_battler = Battler.new(@battle.shift.reverse.lstrip.reverse, '')
    @right_battler = Battler.new(@battle.shift.lstrip, '')
    puts "#{@left_battler.name} vs #{@right_battler.name}"
  end

  def found_text(battle)
    text = battle.click.search('.lyrics p').text.to_s
    authors = text.to_s.scan(/\[[^?\]]+\]/)
    text.to_s.split(/\[[^?\]]+\]/).reject(&:empty?).each do |item|
      part = authors.shift.to_s
      if part.include?(@left_battler.name)
        @left_battler.text += item
      elsif part.include?(@right_battler.name)
        @right_battler.text += item
      end
    end
  end

  def found_winner
    if left_battler.points >= right_battler.points
      puts_winner(left_battler)
    else
      puts_winner(right_battler)
    end
  end

  def puts_winner(winner)
    winner.wins += 1
    if @vip_battler
      @vip_battler.wins += 1 if winner.name == @vip_battler.name
    end
    puts "#{winner.name} WINS!"
    terminal_size = Terminal.size
    delimiter = '=' * terminal_size[:width]
    puts delimiter
  end
end
