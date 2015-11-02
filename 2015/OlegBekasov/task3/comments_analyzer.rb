require 'yaml'
require 'unicode'
class CommentsAnalyzer
  def initialize(comment)
    @comment = Unicode.downcase(comment)
    keywords = YAML.load_file(File.expand_path(('./../keywords.yml'), __FILE__))
    @positive = keywords['positive']
    @negative = keywords['negative']
  end

  def analyze
    count = 0
    @positive.each { |kw| count += 1 if @comment.include? kw }
    @negative.each { |kw| count -= 1 if @comment.include? kw }
    count
  end
end
