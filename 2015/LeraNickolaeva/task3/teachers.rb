SHEDULE_PAGE = "http://www.bsuir.by/schedule/schedule.xhtml"

class Teachers
  def initialize
    @num_group = num_group
  end

  def connection
    agent = Mechanize.new
    search_form = agent.get(format(SHEDULE_PAGE,@num_group))
    agent.submit(search_form, search_form.buttons.first)
  end

  def find_teachers
    @teachers = []
    @page_bsuir.parser.xpath('//div//td//a[@href]').each do |name|
      @teachers.push(name.text)
    end
    @teachers.uniq!
  end
end

