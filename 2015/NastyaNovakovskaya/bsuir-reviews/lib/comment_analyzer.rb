require 'yaml'
require "unicode_utils/downcase"

class CommentAnalyzer

  def self.check_comment(comment_text)
    words = YAML.load_file("./config/keywords.yml")

    negative_words = words['negative']
    positive_words = words['positive']
    downcase_comment_text = UnicodeUtils.downcase(comment_text)

    negative_words_count = 0
    negative_words.each do |word|
      if downcase_comment_text.match('(.)*' + word)
        negative_words_count += 1
      end
    end

    positive_words_count = 0
    positive_words.each do |word|
      if downcase_comment_text.downcase.match('(.)*' + word)
        positive_words_count += 1
      end
    end

    if positive_words_count > negative_words_count
      return 1
    elsif positive_words_count == negative_words_count
      return 0
    else
      return 2
    end

  end
end
