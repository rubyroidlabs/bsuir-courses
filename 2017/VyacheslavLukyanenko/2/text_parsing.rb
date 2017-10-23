require 'mechanize'
require 'date'
require 'json'
require 'nokogiri'

class TextParserr
  attr_accessor :first_count_words, :second_count_words, :link
  attr_accessor :first_battler_name, :second_battler_name

  def initialize(link)
    @link = link
    @wins_count = 0
    @loses_count = 0
    @first_count_words = 0
    @second_count_words = 0
  end

  def parse_n_choose(criteria, name)
    text = @link.css('.lyrics').text
    rounds = text.split(/\[Round [1-3]: /)
    rounds.shift
    rounds.each do |round|
      name_pos = round.index(']')
      raper_name = round[0..name_pos - 1]
      round.slice!(raper_name + ']')
      if @first_battler_name.to_s.empty?
        @first_battler_name = raper_name
      elsif @first_battler_name != raper_name &&
            @second_battler_name.to_s.empty?
        @second_battler_name = raper_name
      end

      if raper_name == @first_battler_name
        if criteria.to_s.empty?
          @first_count_words += round.split.count
        else
          @first_count_words += round.scan(/#{criteria}/).size
        end
      elsif raper_name == @second_battler_name
        if criteria.to_s.empty?
          @second_count_words += round.split.count
        else
          @second_count_words += round.scan(/#{criteria}/).size
        end
      end
    end
    if @first_battler_name.to_s.empty? || @second_battler_name.to_s.empty?
      false
    elsif who_win?(@first_count_words, @second_count_words, criteria)
      what_to_do?(@first_battler_name, @second_battler_name,
                  @first_count_words, @second_count_words, name, criteria)
    else
      what_to_do?(@second_battler_name, @first_battler_name,
                  @second_count_words, @first_count_words, name, criteria)
    end
  end

  def who_win?(x, y, _word)
    f = false
    if x > y
      f = true
    else
      f = false
    end
    f
  end

  def what_to_do?(namef, names, x, y, name, criteria)
    if namef == name
      @wins_count += 1
    end
    if (name.to_s.empty? && criteria.to_s.empty?) || name == namef
      puts "#{namef} vs #{names} - #{@link.uri}"
      puts "#{namef} - #{x}"
      puts "#{names} - #{y}"
      puts "#{namef} WINS!"
      puts
      sleep(5)
    elsif name == names
      @loses_count += 1
    end
  end

  def show_wins_count(name)
    if name.to_s.empty?
      @wins_count = 1
    else
      puts "#{name} wins #{@wins_count} times, loses #{@loses_count} times"
    end
  end
end
