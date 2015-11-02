require 'mechanize'

class CommentsTeachers
  def initialize
    @url = 'http://bsuir-helper.ru'
    @agent = Mechanize.new
    @lectors_list = all_lectors
  end

  def all_lectors
    page = @agent.get("#{@url}/lectors")
    page.parser.css('.views-row a')
  end

  def search_comments(teacher)
    helper_link = nil
    @lectors_list.each do |lectors|
      if lectors.text == teacher
        helper_link = lectors.attributes['href'].value
      end
    end
    helper_link
  end

  def time(link)
    page = @agent.get("#{@ur}#{link}")
    page.parser.css('.comment .submitted .comment-date').map(&:text)
  end

  def content(link)
    page = @agent.get("#{@ur}#{link}")
    page.parser.css('.comment .content').map(&:text)
  end
end
