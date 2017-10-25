require 'mechanize'
require 'json'

class RapParser
  FIRST_INDEXES = [1, 5, 9].freeze
  SECOND_INDEXES = [3, 7, 11].freeze

  def initialize(song_text, criteria = nil)
    @song_text = song_text
    @criteria = criteria
    @first_man = { text: '' }
    @other_man = { text: '' }
  end

  def split_opponents
    rounds = @song_text.scan(/\[Round.*?\]/)
    raise if rounds.size != 6
    @first_man[:name] = split_rounds rounds.first
    @other_man[:name] = split_rounds rounds.last
    texts = @song_text.split(/(\[Round.*?\])/)
    texts.shift
    texts.each_with_index do |text, index|
      if FIRST_INDEXES.include? index
        @first_man[:text] << text
      elsif SECOND_INDEXES.include? index
        @other_man[:text] << text
      end
    end
    criteria_result
    [@first_man, @other_man]
  end

  def criteria_result
    if @criteria.nil?
      count_letters @first_man
      count_letters @other_man
    else
      count_words @first_man
      count_words @other_man
    end
  end

  def split_rounds(rounds)
    rounds.split(':')[1].gsub(/\W+/, ' ').strip
  end

  def count_letters(man)
    man[:criteria_count] = man[:text].gsub(/\W/, '').size.to_i
  end

  def count_words(man)
    man[:criteria_count] = man[:text].scan(@criteria).size.to_i
  end
end
