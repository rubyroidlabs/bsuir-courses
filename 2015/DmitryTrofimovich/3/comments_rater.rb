require 'yaml'

class CommentsRater
  def initialize
    file = YAML.load(File.open('keywords.yml'))
    @bad_words = file['negative']
    @good_words = file['positive']
  end

  def rating_comment(text)
    rating = 0
    @good_words.each { |word| rating += 1 if text.include?(word) }
    @bad_words.each { |word| rating -= 1 if text.include?(word) }
    rating
  end
end
