require 'mechanize'

class HelperTeachersParser
  def parse
    url = 'http://bsuir-helper.ru/lectors'
    agent = Mechanize.new
    lectors_page = agent.get(url)
    teachers = []
    lectors_page.parser.css('.views-row a').each do |link|
      teacher = {}
      teacher[:link] = link.attributes['href'].value
      teacher[:name] = normalize_name(link.text)
      teachers << teacher
    end
    teachers
  end

  private

  def normalize_name(name)
    words = name.split(' ')
    "#{words[0]} #{words[1][0]}. #{words[2][0]}."
  end
end
