class ReviewPrinter
  def self.print_db(review_db)
    review_db.each do |i|
      puts "#{i['lector'].cyan}"
      puts "#{'========='.yellow}"
      if i['dates'].empty?
        puts 'Не найдено отзывов'.magenta
      else
        (0..(i['dates'].size - 1)).each do |x|
          comment = CommentColorizer.new(i['comments'][x])
          comment.get_rating
          @comment = comment.colorize_comment
          print "#{i['dates'][x].blue} #{@comment}\n\n"
        end
      end
      puts
    end
  end
end
