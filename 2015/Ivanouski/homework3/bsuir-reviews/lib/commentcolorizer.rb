class CommentColorizer
  def self.colorize_comment(comment)
    keywords = YAML.load_file('./keywords.yml')
    @pos = 0
    @neg = 0

    keywords['positive'].each do |keyword|
      @pos += (comment).scan(keyword).count
    end
    keywords['negative'].each do |keyword|
      @neg += (comment).scan(keyword).count
    end
    rating = @pos - @neg
    if rating > 0
      comment.green
    elsif rating < 0
      comment.red
    else
      comment
    end
  end
end
