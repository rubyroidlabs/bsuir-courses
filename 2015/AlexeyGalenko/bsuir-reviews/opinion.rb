require 'mechanize'
require 'set'
class Opinion
  def initialize(lecturers_set)
    @lecturers_set = lecturers_set
    @mechanize = Mechanize.new
    @name_to_link = {}
    @name_to_opinions = {}
  end

  def links_to_opinions
    page = @mechanize.get('http://bsuir-helper.ru/lectors')
    rows = page.parser.css("div [class='view view-lectors view-style-Нормальный view-id-lectors view-display-id-page_1'] a")
    rows.each do |row|
      a = row.text.split(' ')
      name = String.new(a[0] << ' ' << a[1][0] << '.' << ' ' << a[2][0] << '.')
      if @lecturers_set.include?(name)
        @name_to_link[name] = "http://bsuir-helper.ru#{row['href']}"
      end
    end
  end

  def opinions
    @name_to_link.each do |name, link|
      opinion_page = @mechanize.get(link)
      dates = fetch_dates(opinion_page)
      comments = fetch_comments(opinion_page)
      opinions_hash(dates, comments, name)
    end
    @name_to_opinions
  end

  def fetch_dates(page)
    dates = []
    rows_date = page.parser.css("div [class='submitted']")
    rows_date.each do |row|
      dates << row.css('span')[1].text
    end
    dates
  end

  def fetch_comments(page)
    comments = []
    rows_comment = page.parser.css("div [id='comments']").css("div [class='content']")
    rows_comment.each do |row|
      comments << row.css('p').text
    end
    comments
  end

  def opinions_hash(dates, comments, name)
    opinions = Set.new
    0.upto(dates.length - 1) do |i|
      opinion = String.new(dates[i] << ':' << ' ' << comments[i])
      opinions.add(opinion)
    end
    opinions.empty? ? @name_to_opinions[name] = ['Не найдено отзывов'] : @name_to_opinions[name] = opinions
  end
end
