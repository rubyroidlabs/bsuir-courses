class Employees
  def initialize(group_id)
    agent = Mechanize.new
    @url = 'http://www.bsuir.by/schedule/schedule.xhtml?id=' + group_id
    @page = agent.get("#{@url}")
    @employees = []
  end

  def get_employees
    @page.links_with(href: /scheduleEmployee/).each do |link|
      @employees.push(link.text)
    end
    @employees.uniq!.sort
  end
end
