require 'mechanize'

class ScheduleParser
  attr_reader :group_id, :lecturers
  def initialize(group_number)
    @group_number = group_number
    @group_id = search_id_group
    @lecturers = search_lecturer
  end

  def search_id_group
    page = Mechanize.new.get('http://www.bsuir.by/schedule/rest/studentGroup')
    page.search('studentGroup').each do |elem|
      if elem.search('name').to_s.scan(/[0-9]{6}/).first == @group_number
        return elem.search('id').to_s.scan(/[0-9]{5}/).first
      end
    end
  end

  def search_lecturer
    lecturers = []
    agent = Mechanize.new
    page = agent.get('http://www.bsuir.by/schedule/rest/schedule/' + @group_id)
    page.search('employee').each do |lecturer|
      lecturers << get_name(lecturer, 'lastName') + ' ' + get_name(lecturer, 'firstName') + ' ' + get_name(lecturer, 'middleName')
    end
    lecturers.uniq
  end

  def get_name(lecturer, name)
    lecturer.search(name).to_s.gsub(/<.*?>/, '')
  end
end
