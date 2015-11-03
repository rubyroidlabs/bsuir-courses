class CommentColorizer
  def initialize(comment)
    @comment = comment
    @keywords = YAML.load_file('./keywords.yml')
    @pos = @neg = 0
  end

  def get_rating
    @keywords['positive'].each do |keyword|
      @pos += (@comment).scan(keyword).count
    end
    @keywords['negative'].each do |keyword|
      @neg += (@comment).scan(keyword).count
    end
    @rating = @pos - @neg
  end

  def colorize_comment
    if @rating > 0
      @comment.green
    elsif @rating < 0
      @comment.red
    else
      @comment
    end
  end
end
