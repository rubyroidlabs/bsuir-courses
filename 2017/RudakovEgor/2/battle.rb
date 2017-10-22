require_relative 'parser'
require 'mechanize'

# class fo battle operations
class Battle
  def initialize
    @signs = []
    @artists = []
  end

  def set_artists(battle_data)
    artist1_name = battle_data[:name].split(/[vV]s.?/)[0].strip
    artist2_name = battle_data[:name].split(/[vV]s.?/)[1].strip
    text_of_battle = battle_data[:text].split(/\[Round [123].+\]/)
    text_of_battle.shift
    artist1_text = []
    artist2_text = []
    text_of_battle.each_with_index do |t, i|
      if i.even?
        artist1_text << t
      else
        artist2_text << t
      end
    end
    artist1_data = { artist1_name: artist1_name, artist1_text: artist1_text }
    artist2_data = { artist2_name: artist2_name, artist2_text: artist2_text }
    @artists << artist1_data
    @artists << artist2_data
  end

  def signs_count
    if ENV['CRITERIA'].nil?
      @artist1[:artist1_text].each { |t| @signs << t.scan(/\w/).size }
      @artist2[:artist2_text].each { |t| @signs << t.scan(/\w/).size }
    else
      @artist1[:artist1_text].each { |t| @signs << t.scan(/#{ENV['CRITERIA']}/).size }
      @artist2[:artist2_text].each { |t| @signs << t.scan(/#{ENV['CRITERIA']}/).size }
    end
    @signs
  end

  def results(battle_data)
    all_signs = signs_count
    artist1_count = all_signs[0] + all_signs[2] + all_signs[4]
    artist2_count = all_signs[1] + all_signs[3] + all_signs[5]
    puts battle_data[:name] + ' - ' + battle_data[:url]
    puts @artist1[:artist1_name] + ' - ' + artist1_count.to_s
    puts @artist2[:artist2_name] + ' - ' + artist2_count.to_s
    if artist1_count > artist2_count
      puts @artist1[:artist1_name] + ' WINS!' + "\n" + ' ' * 90
      @winner = @artist1[:artist1_name]
    elsif artist1_count == artist2_count
      puts 'TIE!' + "\n" + ' ' * 90
    else
      puts @artist2[:artist2_name] + ' WINS!' + "\n" + ' ' * 90
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
      puts battle_data[:name] + ' - ' + battle_data[:url]
      puts "This battle don't have any texts" + "\n" + ' ' * 90
      return
    end
    results(battle_data)
  end

  def stats
    if @winner == ENV['NAME']
      win_counter = 1
    else
      win_counter = 0
    end
      win_counter
  end
end
