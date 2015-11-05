require 'yaml'
require 'unicode'

# TextAnalyzer analyzes text for bad and good words
class TextAnalyzer
  def initialize
    load_words
  end

  def analyze(text)
    count = 0
    text = Unicode.downcase(text)
    @positive_words.each { |word| count += 1 if text.include? word }
    @negative_words.each { |word| count -= 1 if text.include? word }
    count
  end

  private

  def load_words
    words = YAML.load_file('keywords.yml')
    @positive_words = words['positive']
    @negative_words = words['negative']
  end
end
