class Teachers
  def initialize
    @num_group = num_group
    @page_bsuir = page_bsuir
  end

  def connection
    agent = Mechanize.new
    search_form = agent.get("http://www.bsuir.by/schedule/schedule.xhtml?id=#{@num_group}")
		agent.submit(search_form, search_form.buttons.first)
  end

  def find_teachers
    @teachers = []
		@page_bsuir.parser.xpath('//div//td//a[@href]').each do |l|
      @teachers.push
    end
    @teachers.uniq!
  end
end
