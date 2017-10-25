require_relative 'parser'


# class fo battle operations
class Battle
  def initialize
    @signs = []
    @artists = []
  end

  def set_artists(battle_data)
    name_of_artists = battle_data[:name].split(/[vV]s.?/)
    artist1_name = name_of_artists[0].strip
    artist2_name = name_of_artists[1].strip
    text_of_battle = battle_data[:text].split(/\[Round [123].+\]/)
    text_of_battle.shift
    artist1_text = []
    artist2_text = []
    text_of_battle.each_with_index do |t, i|
    i.even? ? artist1_text << t : artist2_text << t
    end
    artist1_data = { artist1_name: artist1_name, artist1_text: artist1_text }
    artist2_data = { artist2_name: artist2_name, artist2_text: artist2_text }
    @artists << artist1_data
    @artists << artist2_data
  end

  def signs_count
    criteria = ENV['CRITERIA']
    size_of_text = lambda do |cr|
      @artist1[:artist1_text].each { |t| @signs << t.scan(cr).size }
      @artist2[:artist2_text].each { |t| @signs << t.scan(cr).size }
    end
    criteria.nil? ? size_of_text.call(/\w/) : size_of_text.call(/criteria/)
      @signs
  end

  def results(battle_data)
    all_signs = signs_count
    artist1_count = all_signs.values_at(* all_signs.each_index.select {|i| i.even?}).sum
    artist2_count = all_signs.values_at(* all_signs.each_index.select {|i| i.odd?}).sum
    puts "#{battle_data[:name]} - #{battle_data[:url]}"
    puts "#{@artist1[:artist1_name]} - #{artist1_count}"
    puts "#{@artist2[:artist2_name]} - #{artist2_count}"
    if artist1_count > artist2_count
      puts "#{@artist1[:artist1_name]} WINS!\n "
      @winner = @artist1[:artist1_name]
    elsif artist1_count == artist2_count
      puts "TIE!\n "
    else
      puts "#{@artist2[:artist2_name]} WINS!\n "
      @winner = @artist2[:artist2_name]
    end
  end

  def set_battle(battle_data)
    text_of_battle = battle_data[:text].split(/\[Round [123].+\]/)
    text_of_battle.shift
    count_of_rounds = text_of_battle.count
    if battle_data[:name] =~ /[vV]s.?/ && count_of_rounds.even? && count_of_rounds != 0
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
