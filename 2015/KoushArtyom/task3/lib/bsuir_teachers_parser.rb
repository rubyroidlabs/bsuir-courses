require 'mechanize'

class BsuirTeachersParser
  def initialize(group)
    @group = group
  end

  def parse
    agent = Mechanize.new
    page = agent.get("http://www.bsuir.by/schedule/schedule.xhtml?id=#{@group}")
    docs = page.parser.css('tr td[6] a')
    teachers = []
    docs.each { |doc| teachers << doc.text }
    if teachers[0].nil?
      puts 'Группа не найдена'
      fail ArgumentError
    end
    teachers = teachers.uniq
    teachers
  end
end
