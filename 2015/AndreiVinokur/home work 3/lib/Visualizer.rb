require 'colored'
require 'rubygems'

class Visualiser
  LINE = "------------------------------------------------------------"
  DOUBLE_LINE = "============================================================"
  def initialize(teachers, reviews, analyz_reviews, analyz_review_teacher)
    @teachers = teachers
    @reviews = reviews
    @analyz_reviews = analyz_reviews
    @analyz_review_teacher = analyz_review_teacher
  end

  def visualise
    puts DOUBLE_LINE
    @teachers.size.times do |i|
      if @analyz_review_teacher[i] == nil
        puts "#{@teachers[i].blue}"
      elsif @analyz_review_teacher[i] > 0.0
        puts "#{@teachers[i].green}  Адекватность:#{@analyz_review_teacher[i]}"
      elsif  @analyz_review_teacher[i] < 0.0
        puts "#{@teachers[i].red}  Адекватность:#{@analyz_review_teacher[i]}"
      end
      puts DOUBLE_LINE
      if @reviews[i].empty?
        puts "Не найдено отзывов\n\n"
      end
      @reviews[i].size.times do |j|
        puts "\n#{@reviews[i][j]}\n\n"
        if @analyz_reviews[i][j] > 0.0
          puts LINE.green
        else
          puts LINE.red
        end
      end
      puts DOUBLE_LINE
    end
  end
end
