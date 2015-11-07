require 'rubygems'
require 'rails-html-sanitizer'
require 'mechanize'
require 'colorize'
require 'unicode'

class Comments
  def initialize(teacher)
    @sanitizer = Rails::Html::FullSanitizer.new
    @url = Mechanize.new.get('http://bsuir-helper.ru/lectors').
        link_with(:text => teacher).click.canonical_uri
    @comments = HTTParty.get(@url).to_s.strip.
        scan(/(?m)<span class="comment-date">.+?<\/div>.+?<\/div>/)
    @teacher = teacher
    @keywords = YAML.load_file('./keywords.yml')
  end

  def color_print
    unless @comments.empty?
      puts @teacher.yellow
      puts '============================='
      @comments.each do |comment|
        @clear_comment = @sanitizer.sanitize(comment)
        @happy_level = happy_level(@clear_comment)
        if @happy_level > 0
          puts @clear_comment.green
        elsif @happy_level < 0
          puts @clear_comment.red
        elsif @happy_level == 0
          puts @clear_comment
        end
      end
      @teacher
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

