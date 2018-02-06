require_relative 'battle'
class BattlesList
  attr_accessor :mc, :criteria, :wins, :loses
  def initialize(mc = nil, criteria = nil)
    @mc = mc
    @criteria = criteria
    @wins = 0
    @loses = 0
  end

  def parse_battles
    agent = Mechanize.new
    page = agent.get('https://genius.com/artists/songs?for_artist_page=117146&id=King-of-the-dot')
    flag = true
    while flag

      page.links_with(text: / vs/).each do |link|
        battle = Battle.new(link)
        battle.final_results
        battle.print_results
      end
      if page.links_with(text: /Next/).empty?
        flag = false
      else
        page = page.link_with(text: /Next/).click
      end
    end
  end

  def parse_battles_of_mc
    agent = Mechanize.new
    page = agent.get('https://genius.com/artists/songs?for_artist_page=117146&id=King-of-the-dot')
    flag = true
    while flag
      if page.links_with(text: /Next/).empty?
        page.links_with(text: / #{@mc}/).each do |link|
          battle = Battle.new(link)
          battle.final_results(@criteria)
          battle.print_results
        end
        flag = false
      else
        page.links_with(text: / #{@mc}/).each do |link|
          battle = Battle.new(link)
          battle.final_results(@criteria)
          battle.print_results
          if @mc == battle.get_winner
            @wins += 1
          else
            @loses += 1
          end
        end
        page = page.link_with(text: /Next/).click
      end
    end
    puts
    puts "#{@mc} wins #{@wins} times, loses #{@loses} times."
  end
end
