class Judge
  def initialize
    @keywords = YAML.load_file('keywords.yml')
  end

  def estimate(comment)
    positive = negative = 0

    @keywords['positive'].each { |word| positive += Unicode::downcase(comment).scan(word).count}
    @keywords['negative'].each { |word| negative += Unicode::downcase(comment).scan(word).count}

    positive <=> negative
  end
end
