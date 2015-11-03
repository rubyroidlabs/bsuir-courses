require 'mechanize'

class CommentFetcher
  def initialize
    agent = Mechanize.new
    @page = agent.get('http://www.bsuir-helper.ru/lectors')
  end

  def add_comments(page, comments)
    page.parser.css('//div.comment/div.content').each do |i|
      unless i.text.strip.empty?
        comments << i.text + "\n"
      end
    end
  end

  def add_dates(page, comments)
    count = 0
    page.parser.css('//div.submitted/span.comment-date').each do |i|
      comments[count].insert(0, i.text + ': ')
      count += 1
    end
    return comments
  end

  def check(comments)
    if comments.empty?
      puts 'Не найдено отзывов' + "\n"
    end
  end

  def get_comments(name)
    comments = Array.new
    begin
      page = @page.links_with(:text => /(?=.*#{name.split(' ')[0]})(?=.*#{name.split(' ')[1]})(?=.*#{name.split(' ')[2]}).*/)[0].click # evil sorcery here
    rescue NoMethodError
      puts 'Не найдено отзывов' + "\n"
      return
    end
    add_comments(page, comments)
    check(comments)
    add_dates(page, comments)
  end

  private :add_comments, :add_dates, :check
end
