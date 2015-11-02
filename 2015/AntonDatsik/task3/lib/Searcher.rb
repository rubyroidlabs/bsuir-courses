require 'mechanize'

class Searcher
  
  def initialize
    @mechanize = Mechanize.new
  end

  def search_for_teachers(group)
    
    page = @mechanize.get('http://www.bsuir.by/schedule/schedule.xhtml?id='.concat(group))
    teachers = Set.new()

    page.links_with(:href => /schedule/).each do |link|
      temp_page = link.click
      str = temp_page.search('span.h2')[1].text
      str.slice!(0, 15)
      teachers.add(str)
    end
    teachers
  end

  def search_for_comments(teacher)
    page = @mechanize.get('http://bsuir-helper.ru/lectors')
    result_array = []
    
    page.links_with(:href => /lectors/).each do |link|
      if link.text.split(' ') == teacher.split(' ')
        comment_page = link.click

        comments = []
        dates = []

        comment_page.search('div.comment div.content').each do |c|
          comments.push(c.text)
        end

        comment_page.search('div.comment div.submitted span.comment-date').each do |d|
          dates.push(d.text)
        end

        for i in 0..dates.length - 1 do
          result_array.push(dates[i].concat(': '.concat(comments[i])))
        end
      end
    end
    result_array
  end
end
