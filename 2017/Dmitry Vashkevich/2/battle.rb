class Battle

  attr_accessor :link_to_battle, :first_name, :second_name, :first_amount_letters, :second_amount_letters

  def initialize (link_to_battle)
    @link_to_battle = link_to_battle
    @first_amount_letters = 0
    @second_amount_letters = 0
  end

  def get_data(text, criterion)
    criterion = '[A-Za-z]' if criterion.nil?
    rounds = text.split(/\[Round [1-3]: /)
    rounds.delete_at(0)
    rounds.each do |round|
      name = round.slice!(0,round.index(']'))
      @first_name ||= name
      if first_name == name
        @first_amount_letters += round.scan(/#{criterion}/).size
      else
        @second_name ||= name
        @second_amount_letters += round.scan(/#{criterion}/).size
      end
    end
  end

  def get_winner
    if first_amount_letters > second_amount_letters
      return first_name
    elsif first_amount_letters < second_amount_letters
      return second_name
    else
      return "Draw"
    end
  end

  def show
      puts "\n#{first_name} VS #{second_name} - #{link_to_battle}"
      puts "#{first_name} - #{first_amount_letters}"
      puts "#{second_name} - #{second_amount_letters}"
      puts "#{get_winner} WINS!"
      puts '_'*70
  end
end
