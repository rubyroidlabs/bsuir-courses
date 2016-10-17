require 'colorize'

class Printer
  attr_reader :reviews
  SEPARATOR = '======='
  NOT_FOUND_MSG = 'Отзывы не найдены.'

  def initialize(reviews)
    @reviews = reviews
  end

  def colored(text)
    if text.sentiment == :negative
      '> ' + text.content.red
    else
      '> ' + text.content.green
    end
  end

  def to_console
    @reviews.each do |t, r|
      puts t
      puts SEPARATOR
      puts NOT_FOUND_MSG if r.count == 0
      r.each do |rw|
        puts colored rw
        puts
      end
      puts
    end
  end
end
