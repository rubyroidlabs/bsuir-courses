class Kodt
  def initialize(name = nil, criteria = nil)
    @rapper = { name: name, number_letters_first: 0, number_letters_second: 0 }
    @name = name
    @criteria = criteria
    @wins = 0
    @loses = 0
    @number_words_first = 0
    @number_words_second = 0
  end

  def show_finish_result
    puts "#{@name} wins #{@wins} times, loses #{@loses} times" if @name
  end
end
