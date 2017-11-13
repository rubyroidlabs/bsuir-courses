class BattleInfo
  attr_reader :left_mc, :right_mc, :title, :link
  attr_writer :winner

  def initialize(left_mc, right_mc, title, link, winner = nil)
    @left_mc = left_mc
    @right_mc = right_mc
    @title = title
    @link = link
    @winner = winner
  end

  def winner
    if left_mc.mc_text_letters_count < right_mc.mc_text_letters_count
      right_mc
    elsif right_mc.mc_text_letters_count < left_mc.mc_text_letters_count
      left_mc
    end
    winner
  end
end
