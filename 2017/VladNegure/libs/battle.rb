require_relative 'battle_page_parser'

class Battle
  attr_reader :criteria

  def initialize(page, criteria = '')
    @criteria = criteria
    @page = page
    left_mc_texts = BattlePageParser.left_mc_texts(@page).join('')
    right_mc_texts = BattlePageParser.right_mc_texts(@page).join('')
    @left_mc_score = count_scores(left_mc_texts)
    @right_mc_score = count_scores(right_mc_texts)
  end

  def results
    "#{BattlePageParser.title(@page)} - #{@page.uri}\n"\
        "#{BattlePageParser.left_mc(@page)}: #{@left_mc_score}\n"\
        "#{BattlePageParser.right_mc(@page)}: #{@right_mc_score}\n"\
        "Winner: #{winner}\n"
  end

  def winner
    if @left_mc_score > @right_mc_score
      BattlePageParser.left_mc(@page)
    elsif @left_mc_score < @right_mc_score
      BattlePageParser.right_mc(@page)
    else
      'Tie'
    end
  end

  private

  def count_scores(text)
    if @criteria == ''
      text.scan(/[\w|\d]/).length
    else
      text.scan(/#{@criteria}/).length
    end
  end
end
