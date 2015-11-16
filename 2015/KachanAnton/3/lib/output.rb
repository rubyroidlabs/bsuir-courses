require 'yaml'
require 'unicode'
require 'colorize'
class Output
  def initialize(lectors_comments)
    @lectors_comments = lectors_comments
    begin
      @keywords = YAML.load(File.open('keywords.yml'))
    rescue ArgumentError => e
      puts "Error: #{e.message}"
    end
  end

  def output
    @lectors_comments.each_pair do |name, comments|
      puts name.colorize(:yellow)
      puts '====='.colorize(:yellow)
      comments.each do |comment|
        output_comment(comment)
      end
    end
  end

  private

  def output_comment(comment)
    positive = 0
    negative = 0
    @keywords['negative'].each do |keyword|
      if Unicode::downcase(comment).include?(keyword)
        negative += 1
      end
    end
    @keywords['positive'].each do |keyword|
      if Unicode::downcase(comment).include?(keyword)
        positive += 1
      end
    end
    com = positive <=> negative
    case com
    when -1
      puts comment.colorize(:red)
    when 1
      puts comment.colorize(:green)
    else
      puts comment
    end
  end
end
