require 'colorize'

class Printer
  def print(analyzer, reviews, dates)
    if (reviews.length == 0)
      puts 'Empty'
      return
    end
    dates.each_index do |i|
      inf = form_output(reviews[i], dates[i])
      print_information(analyzer, inf, reviews[i])
    end
  end

  private

  def form_output(review, date)
    date.concat(': ')
    date.concat(review)
  end

  def print_information(analyzer, inf, review)
    case analyzer.analyze_review(review)
    when :positive
      puts inf.green
    when :negative
      puts inf.red
    else
      puts inf
    end
  end
end
