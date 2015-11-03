class ReviewPrinter
  def initialize(review_db) # Just for Hound and ABC Size
    @review_db = review_db
  end

  def print_db
    @review_db.each do |i| # Another one for Hound and ABC Size
      puts "#{i['lector'].magenta}"
      puts "#{"=========".yellow}"
      if i['dates'].empty?
        puts "Не найдено отзывов"
      else
        (0..(i['dates'].size - 1)).each do |x|
          comment = CommentColorizer.new(i['comments'][x])
          comment.get_rating
          @comment = comment.colorize_comment
          print "#{i['dates'][x].blue} #{@comment} \n"
        end
      end
    print "\n"
    end
  end
end
