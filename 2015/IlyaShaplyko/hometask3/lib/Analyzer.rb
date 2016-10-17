class Analyzer
  def initialize
    @keywords = YAML.load_file('keywords.yml')
  end

  def analyze(comment)
    counter = 0
    @keywords['positive'].each do |word|
      counter += Unicode.downcase(comment).scan(word).count
    end
    @keywords['negative'].each do |word|
      counter -= Unicode.downcase(comment).scan(word).count
    end
    if counter > 0
      puts "-----------\n#{comment.green}"
    elsif counter < 0
      puts "-----------\n#{comment.red}"
    else
      puts "-----------\n#{comment}"
    end
  end
end
