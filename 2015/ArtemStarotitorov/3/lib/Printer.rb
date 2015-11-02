require 'colorize'

class Printer
  def print(analyzer, reviews, dates)
    if (reviews.length == 0)
      puts 'Empty'
      return
    end
    dates.each_index do |i|
      inf = form_output(reviews[i], dates[i])
      case analyzer.analyze_review(reviews[i])
      when :positive
        puts inf.green
      when :negative
        puts inf.red
      else
        puts inf
      end
    end
  end

  def form_output(review, date)
    date.concat(': ')
    date.concat(review)
  end
end
