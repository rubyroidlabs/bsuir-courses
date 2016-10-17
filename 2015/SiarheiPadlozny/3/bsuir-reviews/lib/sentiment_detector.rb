require 'sentimental'

class SentimentDetector
  attr_reader :reviews

  def initialize(reviews)
    @reviews = reviews
  end

  def detect_all
    Sentimental.load_senti_file('../keywords.txt')
    analyzer = Sentimental.new 0.25
    @reviews.each do |_, r|
      r.each do |rw|
        rw.sentiment = analyzer.get_sentiment rw.content
      end
    end
  end
end
