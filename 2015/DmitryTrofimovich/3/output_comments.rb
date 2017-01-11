require 'colorize'
require_relative 'comments_rater'

class OutputComments
  def initialize(hash_lecturers)
    @hash_lecturers = hash_lecturers
    @rater = CommentsRater.new
  end

  def output_on_terminal
    @hash_lecturers.each do |lecturer, comments|
      puts "#{lecturer.blue}\n\n"
      comments.each do |comment|
        case @rater.rating_comment(comment) <=> 0
        when 1
          puts "#{comment.green}\n\n"
        when -1
          puts "#{comment.red}\n\n"
        when 0
          puts "#{comment}\n\n"
        end
      end
      puts '-' * 80
    end
  end
end
