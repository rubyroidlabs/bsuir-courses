require 'yaml'
require 'unicode'
require 'colorize'

class CommentAnalisis
  def initialize
    @config = YAML.load(File.open('./lib/keywords.yml'))
    @positive = @config['positive']
    @negative = @config['negative']
  end

  def analysis(comment)
    comment_downcase = Unicode::downcase(comment)
    count = 0
    @positive.each { |word| count += 1 if comment_downcase.include? word }
    @negative.each { |word| count -= 1 if comment_downcase.include? word }
    output_comment(count, comment)
  end

  def output_comment(count, comment)
    if count > 0
      puts comment.green
    elsif count < 0
      puts comment.red
    else
      puts comment
    end
  end
end
