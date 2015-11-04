require 'colorize'

# Print reviews
class Printer
  attr_accessor :keywords
  def inspect_keywords
    @keywords = YAML.load_file('./keywords.yml')
  end

  def print_lector(lector)
    puts ''
    puts lector.yellow
    puts '====='
  end

  def print_review(review)
    review.each { |date, comment| puts date + ' - ' + parse_comment(comment) }
  end

  def parse_comment(comment)
    positive = positive_count(comment)
    negative = negative_count(comment)
    if positive > negative
      return comment.green
    elsif negative > positive
      return comment.red
    else return comment.blue
    end
  end

  def print_no_review
    puts 'Не найдено отзывов'
  end

  def positive_count(comment)
    inspect_keywords
    positive = 0
    comment.split.each do |word|
      positive += 1 if @keywords['positive'].include?(word.delete('!?.,:;-'))
    end
    positive
  end

  def negative_count(comment)
    negative = 0
    comment.split.each do |word|
      negative += 1 if @keywords['negative'].include?(word.delete('!?.,:;-'))
    end
    negative
  end
end
