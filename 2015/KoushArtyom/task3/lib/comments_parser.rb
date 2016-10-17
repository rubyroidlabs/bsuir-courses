require 'mechanize'
require 'unicode_utils/downcase'

class CommentsParser
  def initialize(bsuir, helper)
    @bsuir = bsuir
    @helper = helper
  end

  def parse
    agent = Mechanize.new
    lectors_and_comments = []
    @helper.each do |h|
      if @bsuir.include?(h[:name])
        l = {}
        teacher_page = agent.get("http://bsuir-helper.ru/#{h[:link]}")
        comments = normalize_comments(teacher_page.parser.css('.comment .content p'))
        l[:lector] = h[:name]
        l[:comments] = comments
        lectors_and_comments << l
      end
    end
    lectors_and_comments
  end

  private

  def normalize_comments(comments)
    comments.map(&:text).reject(&:empty?).map do |comment|
      comment.gsub!(/(\n|\'|\")/, ' ')
      UnicodeUtils.downcase(comment)
    end
  end
end
