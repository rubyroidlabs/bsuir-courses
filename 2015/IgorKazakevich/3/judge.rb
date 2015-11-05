class Judge
  def initialize
    @keywords = YAML.load_file('keywords.yml')
  end

  def estimate(comment)
    positive = negative = 0

    @keywords['positive'].each do |word|
      positive += Unicode::downcase(comment).scan(word).count
    end

    @keywords['negative'].each do |word|
      negative += Unicode::downcase(comment).scan(word).count
    end

    positive <=> negative
  end
end
