class ReviewPrinter
  def initialize(review_db)
    @review_db = review_db
  end

  def print_db
    @review_db.each do |i|
        print "#{i["lector"].magenta}\n#{"==============".yellow} \n"
      if i["dates"].empty?
        print "Не найдено отзывов \n"
      else
        for x in 0..(i["dates"].size - 1)
          @comment = CommentColorizer.colorize_comment(i["comments"][x])
          print "#{i["dates"][x].blue} #{@comment} \n"
        end
      end
      print "\n"
    end
  end
end
