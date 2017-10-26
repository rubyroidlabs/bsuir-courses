require_relative 'parser'

# class fo battle operations
class Battle
  def initialize
    @signs = []
    @artists = []
  end

  def set_artists(battle_data)
    name_of_artists = battle_data[:name].split(/[vV][sS].?/)
    artist1_name = name_of_artists[0].strip
    artist2_name = name_of_artists[1].strip
    text_of_battle = battle_data[:text].split(/\[[rR]ound [123].+\]/)
    text_of_battle.shift
    artist1_text = []
    artist2_text = []
    text_of_battle.each_with_index do |t, i|
      i.even? ? artist1_text << t : artist2_text << t
    end
    artist1_data = { name: artist1_name, text: artist1_text }
    artist2_data = { name: artist2_name, text: artist2_text }
    @artists << artist1_data
    @artists << artist2_data
  end

  def signs_count
    criteria = ENV['CRITERIA']
    size_of_text = lambda do |artist, cr|
      artist[:text].each { |t| @signs << t.scan(cr).size }
    end
    criteria.nil? ? size_of_text.call(@artist1,/\w/) : size_of_text.call(@artist1,/criteria/)
    criteria.nil? ? size_of_text.call(@artist2,/\w/) : size_of_text.call(@artist2,/criteria/)
      @signs
  end

  def results(battle_data)
    all_signs = signs_count
    artist1_count = all_signs.values_at(* all_signs.each_index.select {|i| i.even?}).sum
    artist2_count = all_signs.values_at(* all_signs.each_index.select {|i| i.odd?}).sum
    puts "#{battle_data[:name]} - #{battle_data[:url]}"
    puts "#{@artist1[:name]} - #{artist1_count}"
    puts "#{@artist2[:name]} - #{artist2_count}"
    if artist1_count > artist2_count
      puts "#{@artist1[:name]} WINS!\n "
      @winner = @artist1[:name]
    elsif artist1_count == artist2_count
      puts "TIE!\n "
    else
      puts "#{@artist2[:name]} WINS!\n "
      @winner = @artist2[:name]
    end
  end

  def set_battle(battle_data)
    text_of_battle = battle_data[:text].split(/\[[rR]ound [123].+\]/)
    text_of_battle.shift
    count_of_rounds = text_of_battle.count
    if battle_data[:name] =~ /[vV][sS].?/ && count_of_rounds.even? && count_of_rounds != 0
      @artist1, @artist2 = set_artists(battle_data)
    elsif count_of_rounds < 6
      puts "#{battle_data[:name]} - #{battle_data[:url]}"
      puts "This battle don't have any texts\n "
      return
    end
    results(battle_data)
  end

  def stats
    @winner == ENV['NAME'] ? win_counter = 1 : win_counter = 0
      win_counter
  end
end
