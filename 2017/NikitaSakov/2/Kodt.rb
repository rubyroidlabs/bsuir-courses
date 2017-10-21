class Kodt

  def self.parse
    agent = Mechanize.new 
    page = agent.get("https://genius.com/artists/King-of-the-dot")
    page = page.link_with(text: /Show all songs by King of the Dot/).click
    statistics = Array.new(2, 0)
    loop do
      if page.link_with(text: /Next/).nil?
        page.links_with(text: /vs/).each do |link_of_battle|
          statistics = process_battle(link_of_battle, agent, statistics)
        end
        break
      else
        page.links_with(text: /vs/).each do |link_of_battle|
          statistics = process_battle(link_of_battle, agent, statistics)
        end
        page = page.link_with(text: /Next/).click
      end
    end
    if statistics[0] != 0 or statistics[1] != 0
      puts ENV['NAME'] + ' wins #{statistics[0]} times, loses #{statistics[1]} times'
    end
  end

  def self.process_battle(link_of_battle, agent, statistics)
    page_of_battle = agent.get(link_of_battle.uri)
    title = link_of_battle.to_s.strip
    names = Array.new(2)
    summ_of_letters = Array.new(2, 0)
    if title.include? ('vs.')
      names = ProcessText.find_names(title, names, ' vs. ')
    else
      names = ProcessText.find_names(title, names, ' vs ')
    end
    if ENV['NAME'].nil?
      summ_of_letters = ProcessText.count_letters(page_of_battle, names, summ_of_letters)
      write_results(names, summ_of_letters, link_of_battle)
    else
      if names[0] == ENV['NAME'] or names[1] == ENV['NAME']
        statistics = battle_by_name(link_of_battle, names, statistics)
      end
    end
    statistics
  end

  def self.battle_by_name(link_of_battle, names, statistics)
    agent = Mechanize.new
    summ_of_letters = Array.new(2, 0)
    page_of_battle = agent.get(link_of_battle.uri)
    summ_of_letters = ProcessText.count_letters(page_of_battle, names, summ_of_letters)
    if names[0].include? ENV['NAME'] and summ_of_letters[0] > summ_of_letters[1]
      statistics[0] += 1
    elsif names[1].include? ENV['NAME'] and summ_of_letters[0] < summ_of_letters[1]
      statistics[0] += 1
    else
      statistics[1] += 1
    end
    write_results(names, summ_of_letters, link_of_battle)
    statistics
  end

  def self.write_results(names, summ_of_letters, link_of_battle)
    puts names[0] + " vs " + names[1] + " - " + link_of_battle.uri.to_s
    if summ_of_letters[0] < 100 and summ_of_letters[1] < 100 and ENV['CRITERIA'].nil?
      puts 'The battle still has not come out. The results will be later'
      puts
      return
    elsif summ_of_letters[0] == 0 or summ_of_letters[1] == 0 and ENV['CRITERIA'].nil?
      puts 'The text is written in the wrong. It is impossible to calculate the length.'
      puts
      return
    end
    puts names[0] + ' - ' + summ_of_letters[0].to_s
    puts names[1] + ' - ' + summ_of_letters[1].to_s
    if summ_of_letters[0] > summ_of_letters[1]
      puts names[0] + ' WINS '
    elsif summ_of_letters[1] > summ_of_letters[0]
      puts names[1] + ' WINS '
    else
      puts 'DRAW '
    end
    puts    
  end

end
