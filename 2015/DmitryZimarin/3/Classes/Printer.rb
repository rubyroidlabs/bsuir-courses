require 'colorize'
require './Classes/TeacherPageParser.rb'
require './Classes/ReviewsPageFinder.rb'
require './Classes/ReviewFinder.rb'
require './Classes/Analizator.rb'
class Printer
  def initialize(group_number)
    @group_number = group_number
  end

  def print_teacher
    list = TeacherPageParser.new(@group_number)
    list.teacher_list.each do |teacher_name|
      puts teacher_name
      review_page = ReviewsPageFinder.new(teacher_name).find_page
      if review_page
        print_reviews(review_page)
      else
        p 'Reviews not found'
      end
      puts '____________________________________'
    end
  end

  def print_reviews(reviews_page)
    analyzer = Analizator.new
    review_list = ReviewFinder.new(reviews_page).reviews
    if review_list.length > 0
      review_list.each do |review|
        puts '______'
        if analyzer.analyze(review) == 0
          puts review.text
        else
          puts review.text.green if analyzer.analyze(review) > 0
          puts review.text.red if analyzer.analyze(review) < 0
        end
      end
    else
      p 'Reviews not found'
    end
  end
end
