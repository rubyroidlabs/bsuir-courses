require 'rubygems'
require 'rails-html-sanitizer'
require 'mechanize'
require 'colorize'
require 'unicode'

class Comments
  def initialize(teacher)
    @url =
        Mechanize.new.get('http://bsuir-helper.ru/lectors').
        links.detect { |l| l.text == teacher }.click.canonical_uri
    @comment_regex = /(?m)<span class="comment-date">.+?<\/div>.+?<\/div>/
    @comments = HTTParty.get(@url).to_s.strip.scan(@comment_regex)
    @teacher = teacher
    @keywords = YAML.load_file('./keywords.yml')
  end

  def color_print
    unless @comments.empty?
      puts @teacher.yellow
      puts '============================='.yellow
      @comments.each do |comment|
        @clear_comment = Rails::Html::FullSanitizer.new.sanitize(comment)
        @happy_level = happy_level(@clear_comment)
        comment_print(@happy_level, @clear_comment)
      end
      @teacher
    end
  end

  def comment_print(level, comment)
    if level > 0
      puts comment.green
    elsif level < 0
      puts comment.red
    elsif level == 0
      puts comment
    end
  end

  def happy_level(comment)
    @level = 0
    @lowercase_comment = Unicode::downcase(comment).split(' ')
    @keywords__matches = @keywords['positive'] & @lowercase_comment
    @level += @keywords__matches.size
    @keywords__matches = @keywords['negative'] & @lowercase_comment
    @level -= @keywords__matches.size
  end
end
