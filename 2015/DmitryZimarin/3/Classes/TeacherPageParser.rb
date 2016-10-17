require 'mechanize'

class TeacherPageParser
  def initialize(group_number)
    @group_number = group_number
    @url = 'http://www.bsuir.by/schedule/schedule.xhtml?id=' + @group_number
    @teacher_list = []
    init_teacher_list
  end

  def init_teacher_list
    agent = Mechanize.new
    begin
      schedule_page = agent.get(@url)
    rescue Exception => e
      p "Failed to load the data #{e}"
      return
    end
    schedule_page.search('tbody.ui-datatable-data').search('tr.ui-widget-content').each do |row|
      @teacher_list.push(row.search('td')[5].text.split(' ')[0])
    end
    fail 'Group number you entered not found' if @teacher_list.empty?
    @teacher_list.uniq!.compact!
  end

  attr_accessor :teacher_list
end
