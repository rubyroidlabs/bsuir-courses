require 'mechanize'

class SheduleParser
  def initialize(name_group)
    @name_group = name_group
    @agent = Mechanize.new
  end

  def teachers_list
    url = "http://www.bsuir.by/schedule/schedule.xhtml?id=#{@name_group}"
    links_teachers = []
    begin
      page = @agent.get(url)
    rescue
      puts 'Нет интернет соединения!'
      exit
    end
    teachers = page.parser.css('.ui-datatable-tablewrapper a')
    teachers.each do |i|
      links_teachers << i.attributes['href'].value
    end
    full_name_teachers(links_teachers.uniq)
  end

  def full_name_teachers(links)
    full_name = []
    links.each do |link|
      page_teacher = @agent.get("http://bsuir.by#{link}")
      full_name << page_teacher.search("//input[@class = 'ui-autocomplete-input ui-inputfield ui-widget ui-state-default ui-corner-all']").attribute('value').value
    end
    full_name
  end
end
