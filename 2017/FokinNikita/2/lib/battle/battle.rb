class Battle
  attr_accessor :title, :link, :text, :first_mc,
                :second_mc, :first_score, :second_score, :winner

  def initialize(title, link, text)
    @title = title
    @link = link
    @text = text
    @first_mc = title.split(/[vV]s.?/)[0]
    @second_mc = title.split(/[vV]s.?/)[1]
    @first_score = 0
    @second_score = 0
  end

  def print_result
    puts @title + ' => ' + @link + "\n"
    puts @first_mc.to_s + ' - ' + @first_score.to_s + "\n"
    puts @second_mc.to_s + ' - ' + @second_score.to_s + "\n"
    get_winner
  end

  def get_winner
    if @first_score > @second_score
      puts @first_mc.to_s + ' WIN ' + "\n"
      @winner = @first_mc
    else
      puts @second_mc.to_s + ' WIN ' + "\n"
      @winner = @second_mc
    end
  end

  def win?(name)
    winner.include?(name) ? true : false
  end

  def analyze_text(criteria)
    first_mc_text = []
    second_mc_text = []
    text = @text.split(/\[Round [123].+\]/)
    text.each_with_index do |round, i|
      if i.even?
        first_mc_text << round
      else
        second_mc_text << round
      end
    end
    @first_score = get_score(first_mc_text, criteria)
    @second_score = get_score(second_mc_text, criteria)
  end

  def get_score(text, criteria)
    score = 0
    if criteria.nil?
      text.each do |round|
        score += round.size
      end
    else
      text.each do |round|
        score += round.scan(/#{criteria}/).size
      end
    end
    score
  end
end
