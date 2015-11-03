class Printer
  BLANK_STRING = "\n"
  def initialize(analyzer, lectors_reviews)
    @lectors_reviews = lectors_reviews
    @analyzer = analyzer
  end

  def print
    @lectors_reviews.each do |key, comments|
      print_fio(key.to_s)
      puts '--------------'
      comments.each do |comment|
        print_comment(comment)
        puts BLANK_STRING
      end
      puts BLANK_STRING
    end
  end

  private

  def print_fio(fio)
    fio_arr = fio.split(' ')
    puts "#{fio_arr[0]} #{fio_arr[1][0]}. #{fio_arr[2][0]}."
  end

  def print_comment(comment)
    tone = @analyzer.analyze(comment.review)
    case
    when tone > 0
      puts "#{comment.date}\:  #{comment.review}".green
    when tone < 0
      puts "#{comment.date}\:  #{comment.review}".red
    else
      puts "#{comment.date}\:  #{comment.review}"
    end
  end
end
