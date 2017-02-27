require 'mechanize'

class Parser
  BSUIR_URL = 'http://www.bsuir.by/schedule/schedule.xhtml?id='
  BSUIR_REGEXP = /.+scheduleEmployee.+/
  BSUIR_HELPER_URL = 'http://bsuir-helper.ru/lectors'
  BSUIR_HELPER_REGEXP = /\/lectors\/.+/

  def initialize(group_id)
    @agent = Mechanize.new
    @group_id = group_id
  end

  def parse
    [parse_bsuir, parse_bsuir_helper]
  rescue => e
    abort(e.backtrace)
  end

  private
  def parse_bsuir
    page = @agent.get("#{BSUIR_URL}#{@group_id}")
    group_employees = page.links_with(href: BSUIR_REGEXP).map(&:text)
    group_employees.uniq!
  end

  def parse_bsuir_helper
    page = @agent.get(BSUIR_HELPER_URL)
    all_employees_links = page.links_with(href: BSUIR_HELPER_REGEXP)
    all_employees_name = all_employees_links.map {|link| employee_initials(link.text)}
    all_employees_href = all_employees_links.map(&:href)
    Hash[all_employees_name.zip all_employees_href]
  end

  def employee_initials(text)
    surname, name, patronymic = text.split(' ')
    "#{surname} #{name[0]}. #{patronymic[0]}."
  end
end
