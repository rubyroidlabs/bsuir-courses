class Output
  def initialize(review)
    @review = review
    @words ||= YAML.load_file('../lib/word.yml')
  end

  def print
    count = 0
    @review.delete(',.!').split.each do |x|
      if @words['negative'].include?(x)
        count -= 1
      elsif @words['positive'].include?(x)
        count += 1
      end
    end
    case count <=> 0
    when 1
      puts @review.green
    when 0
      puts @review
    else
      puts @review.red
    end
  end
end
