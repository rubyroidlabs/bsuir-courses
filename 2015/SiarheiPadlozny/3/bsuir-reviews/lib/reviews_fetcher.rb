require 'mechanize'

class ReviewsFetcher
  attr_reader :teachers, :reviews, :all_teachers
  Review = Struct.new :content, :sentiment
  SEARCH_Q = "//div[@class='rounded-inside']//div[@class='content']/p"
  LECTORS_URL = 'http://bsuir-helper.ru/lectors'

  def initialize(teachers)
    @teachers = teachers
    @agent = Mechanize.new
    @all_teachers = []
    @reviews = Hash.new []
  end

  def teachers_reviews
    teachers_hrefs
    @all_teachers.each do |link|
      page = link.click
      rev = page.search SEARCH_Q
      @reviews[link.to_s] = rev.map { |x| Review.new x.text, 0 }
    end
  rescue SocketError
    raise StandartError 'No Internet!'
  end

  private

  def convert_to_standart_format(name)
    name.gsub!(/\(([^\)]+)\)/, '')
    name = name.split
    name.delete_at 1 if name.count > 3
    name[1..2] = name[1..2].map do |t|
      t[0] + '.'
    end
    name.join ' '
  end

  def teachers_hrefs
    @agent.get LECTORS_URL do |page|
      page.links.each do |link|
        if (link.href.to_s.include? 'lectors/') &&
           @teachers.include?(convert_to_standart_format(link.to_s))
          @all_teachers << link
        end
      end
    end
  rescue SocketError
    raise StandartError 'No Internet!'
  end
end
