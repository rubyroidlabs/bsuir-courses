class Battle
  attr_accessor :first_battler, :second_battler,
                :first_battler_rounds, :second_battler_rounds,
                :name, :link, :text, :winner

  private

  def get_name(string)
    string.split(/\[Round \d: /)[1].chomp(']')
  end

  def calculate_letters(text)
    letters = 0
    text.each do |string|
      letters += string.scan(/[a-zA-Z]/).count
    end
    letters
  end

  def calculate_words(text, word)
    words = 0
    text.each do |string|
      words += string.scan(/#{word}|#{word.capitalize}/).count
    end
    words
  end

  def choose_winner(word)
    puts "#{@name} - #{link}"
    unless word.nil?
      first_battler_words = calculate_words(@first_battler_rounds, word)
      second_battler_words = calculate_words(@second_battler_rounds, word)
      puts "#{@first_battler} - #{first_battler_words}"
      puts "#{@second_battler} - #{second_battler_words}"
      if first_battler_words > second_battler_words
        @winner = @first_battler
        puts "#{@winner} WINS!"
        puts "\n\n"
        return
      elsif first_battler_words < second_battler_words
        @winner = @second_battler
        puts "#{@winner} WINS!"
        puts "\n\n"
        return
      else
        puts 'DRAW!'
      end
    end
    first_battler_letters = calculate_letters(@first_battler_rounds)
    second_battler_letters = calculate_letters(@second_battler_rounds)
    puts "#{@first_battler} - #{first_battler_letters}"
    puts "#{@second_battler} - #{second_battler_letters}"
    if first_battler_letters > second_battler_letters
      @winner = @first_battler
      puts "#{@winner} WINS!"
    elsif first_battler_letters < second_battler_letters
      @winner = @second_battler
      puts "#{@winner} WINS!"
    else
      puts 'DRAW!'
    end
    puts "\n\n"
  end

  public

  def initialize(name, link)
    @name = name
    @link = link
    @first_battler_rounds = Array.new
    @second_battler_rounds = Array.new
    get_members
  end

  def get_members
    @first_battler, @second_battler = @name.split(/ vs | vs. | Vs /)
  end

  def parse(word)
    first_battler_text = false
    text.each do |string|
      string.delete!("\n")
    end
    text.delete_if { |string| string.strip.empty? }
    text.each do |string|
      if string =~ /\[Round \d: .+\]/
        first_battler_text = get_name(string) == @first_battler
      elsif first_battler_text
        @first_battler_rounds << string
      else
        @second_battler_rounds << string
      end
    end
    choose_winner(word)
  end

  def battler?(battler)
    [first_battler, second_battler].any? { |mc| mc == battler }
  end
end
