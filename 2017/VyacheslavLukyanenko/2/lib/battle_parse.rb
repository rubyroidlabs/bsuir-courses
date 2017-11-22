require 'mechanize'
require 'date'
require 'json'

class BattleParse
  def initialize(name, criteria)
    @raper_name = { name: name, wins: 0, loses: 0 }
    @criteria = criteria
  end

private

  def parse_n_choose(song_properties)
    text = song_properties[:text]
    @first_count_words = 0
    @second_count_words = 0
    @first_battler_name = ''
    @second_battler_name = ''
    rounds = text.split(/\[Round [1-3]: /)
    rounds.shift
    rounds.each do |round|
      name_pos = round.index(']')
      raper = round[0..name_pos - 1]
      round.slice!(raper + ']')
      what_raper(raper)
      count_words_of_current_raper(raper)
    end
    if @first_battler_name.to_s.empty? || @second_battler_name.to_s.empty?
      false
    elsif who_win?(@first_count_words, @second_count_words)
      what_to_do?(@first_battler_name,
                  @second_battler_name,
                  @first_count_words,
                  @second_count_words,
                  song_properties[:uri])
    else
      what_to_do?(@second_battler_name,
                  @first_battler_name,
                  @second_count_words,
                  @first_count_words,
                  song_properties[:uri])
    end
  end

  def what_raper(raper)
    if @first_battler_name.to_s.empty?
      @first_battler_name = raper
    elsif @first_battler_name != raper &&
          @second_battler_name.to_s.empty?
      @second_battler_name = raper
    end
  end

  def count_words_of_current_raper(raper)
    if raper == @first_battler_name
      @first_count_words += if @criteria.to_s.empty?
                              round.split.count
                            else
                              round.scan(/#{@criteria}/).size
                            end
    elsif raper == @second_battler_name
      @second_count_words += if @criteria.to_s.empty?
                               round.split.count
                             else
                               round.scan(/#{@criteria}/).size
                             end
    end
  end

  def who_win?(x, y)
    x > y
  end

  def what_to_do?(namef, names, x, y, link)
    if namef == @raper_name[:name]
      @raper_name[:wins] += 1
    end
    if (@raper_name[:name].to_s.empty? && @criteria.to_s.empty?) ||
       @raper_name[:name] == namef
      puts "#{namef} vs #{names} - #{link}"
      puts "#{namef} - #{x}"
      puts "#{names} - #{y}"
      puts "#{namef} WINS!"
      puts
    elsif @raper_name[:name] == names
      @raper_name[:loses] += 1
      puts "#{namef} vs #{names} - #{link}"
      puts "#{namef} - #{x}"
      puts "#{names} - #{y}"
      puts "#{names} LOSE!"
      puts
    end
  end

  def show_wins_count
    print "#{@raper_name[:name]} wins #{@raper_name[:wins]} times, loses "
    puts "#{@raper_name[:loses]} times"
  end
end
