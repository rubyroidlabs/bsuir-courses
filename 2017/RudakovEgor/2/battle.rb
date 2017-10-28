require_relative 'parser'

# class fo battle operations
class Battle
  def initialize
    @signs = []
    @artists = []
  end

  def set_artists(battle_data)
    name_of_artists = battle_data[:name].split(/vs.?/i)
    artist1_name = name_of_artists[0].strip
    artist2_name = name_of_artists[1].strip
    text_of_battle = battle_data[:text].split(/\[Round [123].+\]/i)
    text_of_battle.shift
    artist1 = { name: name_of_artists[0].strip, text: [] }
    artist2 = { name: name_of_artists[1].strip, text: [] }
    text_of_battle.each_with_index do |t, i|
      i.even? ? artist1[:text] << t : artist2[:text] << t
    end
    @artists.push(artist1, artist2)
  end

  def count_signs
    criteria = ENV['CRITERIA']
    size_of_text = lambda do |cr|
      @artists.each do |artist|
        artist[:text].each { |t| @signs << t.scan(cr).size }
      end
    end
    criteria.nil? ? size_of_text.call(/\w/) : size_of_text.call(/criteria/)
    @artists[0][:signs_count] = @signs.select.with_index { |_e, i| i.even?}.sum
    @artists[1][:signs_count] = @signs.select.with_index { |_e, i| i.odd?}.sum
  end

  def show_results(battle_data)
    count_signs
    puts "#{battle_data[:name]} - #{battle_data[:url]}"
    @artists.each { |mc| puts "#{mc[:name]} - #{mc[:signs_count]}" }
    if @artists[0][:signs_count] > @artists[1][:signs_count]
      puts "#{@artists[0][:name]} WINS!\n "
      @winner = @artists[0][:name]
    elsif @artists[0][:signs_count] == @artists[1][:signs_count]
      puts "TIE!\n "
    else
      puts "#{@artists[1][:name]} WINS!\n "
      @winner = @artists[1][:name]
    end
  end

  def set_battle(battle_data)
    text_of_battle = battle_data[:text].split(/\[Round [123].+\]/i)
    text_of_battle.shift
    count_of_rounds = text_of_battle.count
    if battle_data[:name] =~ /vs.?/i && count_of_rounds.even? && count_of_rounds != 0
      set_artists(battle_data)
    elsif count_of_rounds < 6
      puts "#{battle_data[:name]} - #{battle_data[:url]}"
      puts "This battle don't have any texts\n "
      return
    end
    show_results(battle_data)
  end

  def stats
    @winner == ENV['NAME'] ? win_counter = 1 : win_counter = 0
      win_counter
  end
end
