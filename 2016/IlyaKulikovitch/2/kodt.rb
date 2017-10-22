class Kodt
  def initialize(name = nil, criteria = nil)
    @name = name
    @criteria = criteria
    @wins = 0
    @loses = 0
    @number_letters_first = 0
    @number_letters_second = 0
    @number_words_first = 0
    @number_words_second = 0
  end

  def show_finish_result
    if @name then puts "#{@name} wins #{@wins} times, loses #{@loses} times." end
  end
end
