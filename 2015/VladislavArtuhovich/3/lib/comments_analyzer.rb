class CommentsAnalyzer
  def load_file
    keywords = YAML.load_file('keywords.yml')
    keywords
  end

  def positive_comment?(comment)
    keywords = load_file
    positive = 0
    negative = 0

    comment_for_analyzing = Unicode::downcase(comment)
    keywords['negative'].each do |keyword|
      if comment_for_analyzing.include? keyword
        negative += 1
      end
    end

    keywords['positive'].each do |keyword|
      if comment_for_analyzing.include? keyword
        positive += 1
      end
    end

    if positive > negative
      1
    elsif positive < negative
      -1
    else
      0
    end
  end
end 
