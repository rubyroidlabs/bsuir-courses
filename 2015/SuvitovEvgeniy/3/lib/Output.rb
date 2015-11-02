class Output
  def initialize(review)
    @review = review
    @words ||= YAML.load_file('../lib/word.yml')
  end

  def print
    count = 0
    @review.delete(',.!').split.each do |x|
      count -= 1 if @words['negative'].include?(x)
      count += 1 if @words['positive'].include?(x)
    end
    if count > 0
      puts @review.green
    elsif count < 0
      puts @review.red
    else
      puts @review
    end
  end
end
