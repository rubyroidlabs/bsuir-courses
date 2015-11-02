require 'mechanize'
class ReviewsParse
  def initialize(names)
    @names = names
  end

  def rev_parse
    agent = Mechanize.new
    page = agent.get('http://bsuir-helper.ru/lectors')
    reviews = {}
    @names.each do |name|
      surname, fstname, dadname = name.split 
      link = page.link_with(:text  =>
        %r{#{surname}\s+#{fstname[0]}[а-я]+\s+#{dadname[0]}[а-я]+})
      unless link.nil?
        comments_link = link.click
        comments = {}
        comments_link.search('.comment').each do |n|
          date = n.search('.comment-date').text
          comment = n.search('.content').text
          comments[date] = comment
        end
        reviews[name] = comments
      else
        reviews[name] = nil
      end
    end
    reviews
  end
end
