require 'colorize'
class ReviewsPrint
  def initialize(reviews)
    @reviews = reviews
  end

  def show_reviews
    @reviews.each do |name, comments|
      show_name(name)
      show_comments(comments)
    end
  end

  private

  def show_name(name)
    puts name.colorize(:light_blue)
    puts '==============='
  end

  def show_comments(comments)
    if comments.empty?
      puts 'Не найдено отзывов'.colorize(:light_red)
      puts ''
    else
      comments.each do |date, comment|
        count = CommentsAnalyzer.new(comment).analyze
        case count
        when 1 then puts "#{date}: #{comment}".colorize(:green)
        when 0 then puts "#{date}: #{comment}"
        when -1 then puts "#{date}: #{comment}".colorize(:red)
        end
        puts ''
      end
    end
  end
end
