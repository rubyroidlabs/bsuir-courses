# helps get the winner
class Battle
  def initialize(first:, second:)
    @first = first
    @second = second
  end

  def result(criteria = nil)
    @first[:count] = counter(@first[:text], criteria)
    @second[:count] = counter(@second[:text], criteria)
    decision = { first: @first,
                 second: @second,
                 winner: winner,
                 result_text: result_text }
    decision = result if decision[:winner].nil? && !criteria.nil?
    decision
  end

  private

  def result_text
    text = "\n#{@first[:name]} = #{@first[:count]}\
          \n#{@second[:name]} = #{@second[:count]}"
    text += winner ? "\n#{winner} WINS" : "\nDRAW"
    text
  end

  def winner
    if @first[:count] > @second[:count]
      @first[:name]
    elsif @first[:count] < @second[:count]
      @second[:name]
    end
  end

  def counter(text, criteria)
    if criteria
      words_count(text, criteria.downcase)
    else
      letters_count(text)
    end
  end

  def letters_count(text)
    words = text.split(' ')
    words.inject(0) do |memo, word|
      memo + word.scan(/\w+/).join.size
    end
  end

  def words_count(text, search)
    text.split(' ').select { |word| word.downcase.match?(/#{search}/) }.size
  end
end
