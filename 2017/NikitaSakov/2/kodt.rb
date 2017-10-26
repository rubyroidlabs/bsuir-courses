class Kodt
  def self.parse
    agent = Mechanize.new
    page = agent.get('https://genius.com/artists/King-of-the-dot')
    page = page.link_with(text: /Show all songs by King of the Dot/).click
    statistics = Array.new(2, 0)
    loop do
      page.links_with(text: /vs/i).each do |link_of_battle|
        statistics = process_battle(link_of_battle, agent, statistics)
      end
      if page.link_with(text: /Next/).nil?
        break
      else
        page = page.link_with(text: /Next/).click
      end
    end
    until statistics.any?(&:zero?)
      puts "#{ENV['NAME']} wins #{statistics.first} times"
      break
    end
  end

  def self.process_battle(link_of_battle, agent, statistics)
    page_of_battle = agent.get(link_of_battle.uri)
    title = link_of_battle.to_s.strip
    names = Array.new(2)
    summ = Array.new(2, 0)
    names = if title.include? 'vs.'
              Text.find_names(title, names, ' vs. ')
            else
              Text.find_names(title, names, / vs /i)
            end
    if ENV['NAME'].nil?
      summ = Text.count_letters(page_of_battle, names, summ)
      write_results(names, summ, link_of_battle)
    elsif names.first == ENV['NAME'] || names.last == ENV['NAME']
      statistics = battle_by_name(link_of_battle, names, statistics)
    end
    statistics
  end

  def self.battle_by_name(link_of_battle, names, statistics)
    agent = Mechanize.new
    summ = Array.new(2, 0)
    page_of_battle = agent.get(link_of_battle.uri)
    summ = Text.count_letters(page_of_battle, names, summ)
    if names.first.include?(ENV['NAME']) && summ.first > summ.last
      statistics[0] += 1
    elsif names.last.include?(ENV['NAME']) && summ.first < summ.last
      statistics[0] += 1
    else
      statistics[1] += 1
    end
    write_results(names, summ, link_of_battle)
    statistics
  end

  def self.write_results(names, summ, link_of_battle)
    puts "#{names.first} vs #{names.last} - #{link_of_battle.uri.to_s}"
    if summ.first < 100 && summ.last < 100 && ENV['CRITERIA'].nil?
      puts 'The results will be later'
      return
    elsif summ.first.zero? && summ.last.zero? && ENV['CRITERIA'].nil?
      puts 'It is impossible to calculate the length.'
      return
    end
    puts "#{names.first} - #{summ.first.to_s}"
    puts "#{names.last} - #{summ.last.to_s}"
    if summ.first > summ.last
      puts "#{names.first} WINS"
    elsif summ.last > summ.first
      puts "#{names.last} WINS"
    else
      puts 'DRAW '
    end
    puts
  end
end
