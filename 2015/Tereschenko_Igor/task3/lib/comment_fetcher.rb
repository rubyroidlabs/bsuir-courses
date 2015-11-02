require 'mechanize'

class CommentFetcher

  def initialize
    agent = Mechanize.new
    @page = agent.get('http://www.bsuir-helper.ru/lectors')
  end

  def get_comments(name)
    comments = Array.new
    begin
      page = @page.links_with(:text => /#{name}/)[0].click
    rescue NoMethodError
      puts 'Не найдено отзывов' + "\n"
      return
    end
    page.parser.css('//div.comment/div.content').each do |i|
      unless i.text.strip.empty?
        comments << i.text + "\n"
      end
    end
    count = 0
    page.parser.css('//div.submitted/span.comment-date').each do |i|
      comments[count].insert(0, i.text + ': ')
      count += 1
    end
    if comments.empty?
      puts 'Не найдено отзывов' + "\n"
      return
    end
    return comments
  end
end
