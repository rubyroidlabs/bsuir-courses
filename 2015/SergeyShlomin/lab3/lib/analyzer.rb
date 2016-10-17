class Analyzer
  def initialize
    @keywords = YAML.load_file('keywords.yml')
    @positive = @keywords['positive']
    @negative = @keywords['negative']
  end

  def analyze(comment)
    comment = Unicode::downcase(comment)
    tone = 0
    @positive.each do |word|
      tone += comment.scan(word).count
    end
    @negative.each do |word|
      tone -= comment.scan(word).count
    end
    tone
  end
end
