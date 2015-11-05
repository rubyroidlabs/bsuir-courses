HELPER_ADDRESS = 'http://bsuir-helper.ru/lectors'
HELPER_FORM = 'search_block_form'
HELPER_FIELD = 'search-block-form'

class Comment
  attr_reader :text_comments
  attr_reader :date_comments

  def initialize(teacher)
    @teacher = teacher
    @page_teacher = connect_to_helper
  end

  def connect_to_helper
    agent = Mechanize.new

    agent.get(HELPER_ADDRESS).links.each do |link|
      return link.click if link.text.include? @teacher.split('.').first
    end
    false
  end

  def find
    if @page_teacher
      @text_comments = find_text_comments
      @date_comments = find_date_comments
    end
  end

  def find_text_comments
    text_comments = Array.new
    @page_teacher.parser.css('div#comments').
      search('.content//p').each do |comment|
        text_comments.push(comment.text)
      end

    text_comments
  end

  def find_date_comments
    date_comments = Array.new

    @page_teacher.parser.css('.submitted').
      search('.comment-date').each do |date|
        date_comments.push(date.text)
      end

    date_comments
  end
end
