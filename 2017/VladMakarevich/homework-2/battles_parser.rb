require_relative 'battler'
class BattlesParser
  BATTLERS_NAMES_IDENTIFIER = 'header_with_cover_art-primary_info-title'.freeze
  ROUND_IDENTIFIER = 'lyrics'.freeze

  def initialize
    @first_battler = nil
    @second_battler = nil
  end

  def parse(links_to_battles, search_criteria, required_battler)
    return unless
        links_to_battles.to_s.downcase.include? required_battler.name.downcase
    links_to_battles.each do |link|
      battle = link.click
      next unless link.to_s.downcase.include? required_battler.name.downcase
      memory_allocation_for_battlers
      battle_rounds = text_division battle
      next unless set_battlers_names?(battle, required_battler)
      rounds_analysis(battle_rounds, search_criteria)
      set_winner
      get_battle_info(link)
    end
  end

  # The method creates two new objects for each battle
  def memory_allocation_for_battlers
    @first_battler = Battler.new
    @second_battler = Battler.new
  end

  def text_division(battle)
    battle_rounds = battle.search(".#{ROUND_IDENTIFIER}")
    battle_rounds = battle_rounds.text.split(/Round [0-9]: /)
    battle_rounds.delete_at 0
    battle_rounds
  end

  def set_battlers_names?(battle, required_battler)
    unless validation_of_names?(battle)
      return false
    end
    battlers_names = clearing_names_battlers(battle)
    @first_battler.name = battlers_names[0]
    @second_battler.name = battlers_names[1]
    unless required_battler.name.empty?
      search_required_battler(required_battler)
    end
    true
  end

  # The method assigns the link of the required battler,
  # to the battler whose name coincides with the search
  def search_required_battler(required_battler)
    req_name = required_battler.name
    first_name = @first_battler.name
    if req_name =~ /(#{first_name})/i || first_name =~ /(#{req_name})/i
      required_battler.name = @first_battler.name
      @first_battler = required_battler
    else
      required_battler.name = @second_battler.name
      @second_battler = required_battler
    end
  end

  # The method "clears" the names of participants from unnecessary information
  def clearing_names_battlers(battle)
    battlers_names = get_battlers_names(battle)
    battlers_names[0].slice!(0, battlers_names[0].index(/\w/))
    battlers_names[0].slice!(0, battlers_names[0].reverse!.index(/\w/))
    battlers_names[0].reverse!
    battlers_names[1].slice!(0, battlers_names[1].index(/\w/))
    battlers_names[1].slice!(/([\(\[]Title Match[\)\]])/i)
    battlers_names[1].slice!(0, battlers_names[1].reverse!.index(/[\w\]\)]/))
    battlers_names[1].reverse!
    battlers_names
  end

  def get_battlers_names(battle)
    battlers_names = battle.search(".#{BATTLERS_NAMES_IDENTIFIER}")
    battlers_names.text.split(/vs/i)
  end

  def validation_of_names?(battle)
    battlers_name = get_battlers_names(battle)
    first_name = battlers_name[0]
    second_name = battlers_name[1]
    return false if first_name.size <= 0 || second_name.size <= 0
    return false unless first_name || second_name
    true
  end

  def rounds_analysis(battle_rounds, search_criteria)
    battle_rounds.each do |round|
      name = round.slice!(0, round.index("\n"))
      name.slice!(0, name.index(/\w/))
      name.delete!('[]')
      if search_criteria
        round = round.downcase.scan(/#{search_criteria}/i)
      else
        round.gsub!(/\W/, '')
      end
      adding_points(@first_battler.name, @second_battler.name, name, round)
    end
  end

  # The method determines whether the name
  # of the current participant is part of its full name.
  # Thanks to this method, you can parse feats
  def adding_points(first_name, second_name, name, round)
    if first_name =~ /(#{name})/i || name =~ /(#{first_name})/i
      @first_battler.points += round.size
    elsif second_name =~ /(#{name})/i || name =~ /(#{second_name})/i
      @second_battler.points += round.size
    end
  end

  def set_winner
    if @first_battler.points > @second_battler.points
      @first_battler.count_of_wins += 1
      @second_battler.count_of_defeat += 1
    elsif @second_battler.points > @first_battler.points
      @second_battler.count_of_wins += 1
      @first_battler.count_of_defeat += 1
    end
  end

  def get_battle_info(link)
    puts "\n\n"
    p '===================================='
    p "Adress: #{link.uri}"
    p "Name: #{@first_battler.name}, Points: #{@first_battler.points}"
    p "Name: #{@second_battler.name}, Points: #{@second_battler.points}"
    if @first_battler.points > @second_battler.points
      p "Winner: #{@first_battler.name}"
    else
      p "Winner: #{@second_battler.name}"
    end
    p '====================================='
    true
  end
end
