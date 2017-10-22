require 'mechanize'
require 'json'

class RapParser
  def initialize(song_text, criteria = nil)
    @song_text = song_text
    @criteria = criteria
    @first_man = { text: '' }
    @other_man = { text: '' }
  end

  def split_opponents
    rounds = @song_text.scan(/\[Round.*?\]/)
    raise if rounds.size != 6
    @first_man[:name] = rounds[0].split(':')[1].gsub(/\W+/, ' ').strip
    @other_man[:name] = rounds[1].split(':')[1].gsub(/\W+/, ' ').strip
    texts = @song_text.split(/(\[Round.*?\])/)
    texts.shift
    first_indexes = [1, 5, 9]
    second_indexes = [3, 7, 11]
    texts.each_with_index do |text, index|
      if first_indexes.include? index
        @first_man[:text] << text
      elsif second_indexes.include? index
        @other_man[:text] << text
      end
    end
    criteria_result
    [@first_man, @other_man]
  end

  def criteria_result
    if @criteria.nil?
      @first_man[:criteria_count] = @first_man[:text].gsub(/\W/, '').size.to_i
      @other_man[:criteria_count] = @other_man[:text].gsub(/\W/, '').size.to_i
    else
      @first_man[:criteria_count] = @first_man[:text].scan(@criteria).size.to_i
      @other_man[:criteria_count] = @other_man[:text].scan(@criteria).size.to_i
    end
  end
end
