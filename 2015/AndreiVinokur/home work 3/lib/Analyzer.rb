require 'textmood'

class Analyzer
  
  def initialize(texts)
    @tm = TextMood.new(language: "ru")
    @comment = texts
  end

  def reviews_comments
    score_one = @comment.map do |comm|
      (@tm.analyze(comm) + 2) 
    end
  end

  def reviews_teacher
    score = @comment.map do |comm|
      @tm.analyze(comm) + 2
    end
    score.inject { |sum, n| sum + n  }  
  end
end
