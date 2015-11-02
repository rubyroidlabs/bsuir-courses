require 'yaml'
require 'colorize'
require 'unicode'

class ParserYaml
  def initialize
    @hash_values = YAML.load(File.open("./keywords.yml"))
    @positive_words = @hash_values['positive']
    @negative_words = @hash_values['negative']
  end

  def execute(comment)
    comment_kind = 0
    comment = Unicode::downcase(comment)
    @positive_words.each {|word| comment_kind += 1 if comment.include? ' ' + word }
    @negative_words.each {|word| comment_kind -= 1 if comment.include? ' ' + word }
    comments_coloring(comment,comment_kind)
  end

  def comments_coloring(comment,comment_kind)
    if comment_kind > 0
      puts comment.green
    elsif comment_kind < 0
      puts comment.red
    else 
      puts comment.white
    end
  end
end
