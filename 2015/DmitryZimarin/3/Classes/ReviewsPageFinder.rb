require 'mechanize'
class ReviewsPageFinder
  def initialize(surname)
    @url = 'http://bsuir-helper.ru/lectors'
    @surname = surname
    @page
  end

  def find_page
    agent = Mechanize.new
    teacher_page = agent.get(@url)
    teacher_page.links.each do |link|
      @page = link.click if link.text.include?(@surname)
      break if link.text.include?(@surname)
    end
    @page
  end
end
