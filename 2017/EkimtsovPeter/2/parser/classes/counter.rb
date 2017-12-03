require_relative '../classes/console'

# Counts letters or words in the text
class Counter
  def initialize(text, names, link)
    @name = ENV['NAME'] unless ENV['NAME'].nil?
    @word = ENV['CRITERIA'] unless ENV['CRITERIA'].nil?
    @first_count = @second_count = 0
    @text = text
    @names = names
    @link = link
  end

  def letters_count
    @text.odd_values.each do |text_first|
      text_first.delete!(' ', '')
      @first_count += text_first.length
    end

    @text.even_values.each do |text_second|
      text_second.delete!(' ', '')
      @second_count += text_second.length
    end
    Console.new(@names, @link, @first_count, @second_count, winner).display_res
  end

  def condition_counter
    @text.odd_values.each do |text_first|
      text_first.split(' ').each { |word| @first_count += 1 if word == @word }
    end

    @text.even_values.each do |text_second|
      text_second.split(' ').each { |word| @second_count += 1 if word == @word }
    end
    Console.new(@names, @link, @first_count, @second_count, winner).display_res
  end

  def wins_loses_counter
    winner == @name
  end

  private

  def winner
    if @first_count > @second_count
      @names.first
    else
      @names.last
    end
  end
end
