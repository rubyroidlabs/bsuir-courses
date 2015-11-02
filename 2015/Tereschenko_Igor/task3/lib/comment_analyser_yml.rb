require 'yaml'
require 'unicode_utils'

class YmlAnalysis
  attr_reader :keywords
  def initialize
    @keywords = YAML.load(File.read('../keywords.yml'))
  end

  def analyze (comment)
    positive = 0
    negative = 0

    comment = UnicodeUtils.downcase(comment)
    comment.to_s.gsub(/[[:punct:]]/, '').split.each do |i|
      if @keywords['positive'].include?(i)
        positive += 1
      elsif @keywords['negative'].include?(i)
        negative += 1
      end
    end

    if positive > negative
      return :positive
    elsif negative > positive
      return :negative
    else
      return :neutral
    end
  end
end
