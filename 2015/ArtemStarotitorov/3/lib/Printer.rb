require 'colorize'

class Printer
  def print(analyzer, reviews, dates)
    if (reviews.length == 0)
      puts 'Empty'
      return
    end
    for i in 0..dates.length - 1 do
      dates[i].concat(": ")
      inf = dates[i].concat(reviews[i])
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
end
