class Battler
  def initialize(name = nil, criteria = nil)
    @name = name
    @criteria = criteria
    @agent = Mechanize.new { |agent1|
      agent1.user_agent_alias = 'Mac Safari'
    }
    @home_page = @agent.get('https://genius.com/artists/King-of-the-dot')
    @loses = 0
    @wins = 0
  end

  def get_battles
    b = @home_page.link_with(text: /\Show all songs/)
    @home_page = @agent.click(b)
  end

  def text_insteadof_html(battle_text)
    until battle_text.index('<a').nil?
      start =  battle_text.index('<a')
      quote_start = 'possibly-branded="false">'
      start_index = battle_text.index(quote_start)
      quote_end = battle_text.index('</a>')
      left_text = battle_text[quote_end + 4, battle_text.length - 1 - quote_end]
      quote_length = quote_end - start_index - quote_start.length
      quote_text = battle_text[start_index + quote_start.length, quote_length]
      battle_text = battle_text[0, start] + quote_text + left_text
    end
    battle_text
  end

  def clear_text(battle_text)
    ['<br>', '<br/>', '<p>', '<\p>', '</p>', '\p', '/p', '<p>'].each do |str|
      until battle_text.index(str).nil?
        a = battle_text.index(str)
        first = battle_text[0, a]
        second = battle_text[a + str.length, battle_text.length - 1]
        battle_text = first + second
      end
    end

    battle_text = text_insteadof_html(battle_text)
    battle_text
  end

  def parse_battles
    get_text_and_link(@home_page)
    filter = /^\d+$/
    @home_page.links_with(:text => filter).each do |link|
      a = @agent.click(link)
      get_text_and_link(a)
    end
  end

  def page_was_found(battle_page)
    battle_name = battle_page.text.strip
    pos = battle_name.index(/\([a-zA-Z\d\D]+\)/)
    unless pos.nil?
      battle_name = battle_name[0, pos-1]
      names = battle_name.split(' vs ')
      c = @agent.click(battle_page)
      battle_text = c.css('.lyrics').css('p').to_s
      battle_text = clear_text(battle_text.to_s)
      if !@name.nil?
        unless battle_name.index(@name).nil?
          puts battle_name + " - #{battle_page.href}\n"
          win_or_lose(battle_text, names)
          puts "************************************\n"
        end
      else
        puts battle_name + " - #{battle_page.href}\n"
        find_by_criteria(battle_text, names)
        puts "************************************\n"
      end
    end
  end

  def get_text_and_link(page)
    page.links.each do |battle_page|
      if battle_page.text.strip =~ /\svs\s/
        page_was_found(battle_page)
      else
        next
      end
    end
  end


  def count_letters(text)
    letters = 0
    text.each_char do |letter|
      letters += 1 unless text[letter] =~ /[^A-Za-z]/
    end
    letters
  end

  def count_criteria(text)
    criteria_counter = 0
    pos = 0
    until text.index(@criteria, pos).nil?
      pos = text.index(@criteria, pos + 1)
      if !pos.nil?
        if text.length <= pos
          break
        end
      elsif pos.nil?
        break
      end
      criteria_counter += 1
    end
    criteria_counter
  end

  def win_or_lose(battle_text, names)
    letters = []
    letters.push(0)
    letters.push(0)
    unless battle_text.index('[This battle is yet to be released]').nil?
      puts 'This battle has no lyrics yet'
      return
    end
    1.upto(3) do |round|
      0.upto(1) do |name|
        break if battle_text.nil?
        str = '[Round ' + round.to_s + ': ' + names[name].to_s + ']'
        temp = battle_text.index(str)
        start_round = 0
        start_round = temp + str.length unless temp.nil?
        end_round = battle_text.index('[Round ', start_round)
        end_round = battle_text.length - 1 if end_round.nil?
        start_text = start_round - str.length
        end_text = end_round - start_round + str.length
        text = battle_text[start_text, end_text]
        break if text.nil?
        if @criteria.nil?
          letters[name] += count_letters(text)
        else
          letters[name] += count_criteria(text)
          letters
        end
        battle_text[start_text..end_text - 1] = ''
      end
    end
    puts "\n#{names[0]} - #{letters[0]}"
    puts "#{names[1]} - #{letters[1]} \n"
    if letters[0] > letters[1]
      if !names[0].index(@name).nil?
        @wins += 1
      else
        @loses += 1
      end
    elsif letters[1] > letters[0]
      if !names[1].index(@name).nil?
        @wins += 1
      else
        @loses += 1
      end
    else
      puts "\nGODDAMN! IT'S A TIE!!!"
    end
  end

  def find_by_criteria(battle_text, names)
    letters = Array.new
    letters.push(0)
    letters.push(0)
    unless battle_text.index('[This battle is yet to be released]').nil?
      puts 'This battle has no lyrics yet'
      return
    end
    1.upto(3) do |round|
      0.upto(1) do |name|
        break if battle_text.nil?
        str = '[Round ' + round.to_s + ': ' + names[name].to_s + ']'
        start_round = 0
        temp = battle_text.index(str)
        start_round = temp + str.length unless temp.nil?
        end_round = battle_text.index('[Round ', start_round)
        end_round = battle_text.length - 1 if end_round.nil?
        start_text = start_round - str.length
        end_text = end_round - start_round + str.length
        text = battle_text[start_text, end_text]
        break if text.nil?
        if @criteria.nil?
          letters[name] += count_letters(text)
        else
          letters[name] += count_criteria(text)
          letter
        end
        battle_text[start_text..end_text - 1] = ''
      end
    end
    puts "\n#{names[0]} - #{letters[0]}"
    puts "#{names[1]} - #{letters[1]} \n"
    if letters[0] > letters[1]
      puts "\n#{names[0]} - WINS!"
    elsif letters[1] > letters[0]
      puts "\n#{names[1]} - WINS!"
    else
      puts "\nGODDAMN! IT'S A TIE!!!"
    end
  end

  def make_conclusion
    unless @name.nil?
      puts "#{@name} wins in #{@wins} battles" \
      " and loses in #{@loses}."
      @name
    end
  end
end
