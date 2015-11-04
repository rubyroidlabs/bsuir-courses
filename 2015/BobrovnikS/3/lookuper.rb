require 'mechanize'

# LookUp review data
class LookUper
  attr_accessor :group, :lectors, :comments, :dates, :page, :agent, :reviews
  def initialize(group_number)
    @group = group_number
    @lectors ||= []
    @comments ||= []
    @reviews = {}
    @dates = []
  end

  def seek_lectors
    agent = Mechanize.new
    pg = agent.get('http://www.bsuir.by/schedule/schedule.xhtml?id=' + @group)
    fail 'Данной группы не существует !' if pg.nil?
    pg.links.each do |link|
      @lectors.push(link.text)
    end
    @lectors = @lectors.values_at(3..-6).uniq
  end

  def seek_reviews(lector)
    printer = Printer.new
    seek_page(lector)
    if @page.nil?
      printer.print_no_review
      return nil
    end
    seek_dates_and_comments
    @reviews = [@dates, @comments].transpose.to_h
    printer.print_review(@reviews)
  end

  def seek_dates_and_comments
    @page.search('div.clear-block').each do |content|
      @dates.push(content.search('span.comment-date').text)
      @comments.push(content.search('div.content p').text)
    end
  end

  def seek_page(lector)
    agent = Mechanize.new
    pg = agent.get('http://bsuir-helper.ru/lectors')
    pg.links.each do |link|
      val = lector.split(' ')
      lector_name = val[0] + ' ' + val[1][0]
      @page = link.click if link.text.include?(lector_name)
    end
    @page
  end
end
