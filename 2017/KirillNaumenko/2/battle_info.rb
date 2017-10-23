# Winner
class BattleInfo
  attr_reader :left_mc, :right_mc, :title, :link
  attr_writer :winner

  def initialize(left_mc, right_mc, title, link)
    @left_mc = left_mc
    @right_mc = right_mc
    @title = title
    @link = link
    @winner = winner
  end

  def winner
    if left_mc.letters_count < right_mc.letters_count
      winner = right_mc
    elsif right_mc.letters_count < left_mc.letters_count
      winner = left_mc
    else
      puts 'Tie!'
    end
    winner
  end
end
