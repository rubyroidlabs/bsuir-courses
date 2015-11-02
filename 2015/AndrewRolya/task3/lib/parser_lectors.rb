require 'mechanize'
require 'unicode'

class ParserLectors
  def initialize
    @agent = Mechanize.new
    @url = "http://bsuir-helper.ru/lectors"
    @dates = Array.new
  end

  def search_comments(teacher_name)
    page = @agent.get(@url)
    comments = Array.new
    dates = Array.new
    page.links_with(:href => /lectors/).each do |link|
      if teacher_name == link.text 
        page = link.click
        page.parser.css('.comment .content').map{|comment| comments << comment.text}
        page.parser.css('.comment .comment-date').map{|date| dates << date.text}
        @dates = dates
      end
    end
    comments
  end

  def search_dates
    @dates
  end
end
