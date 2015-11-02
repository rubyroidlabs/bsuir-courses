class ScheduleParser
  def get_teachers_list(group_number)
    teachers_list = Array.new
    mechanize = Mechanize.new
    schedule_page = mechanize.get(generate_link_to_schedule(group_number))
    schedule_page.search('employee').each do |employee|
      first_name = employee.search('firstName').text
      middle_name = employee.search('middleName').text
      last_name = employee.search('lastName').text
      teachers_list.push("#{last_name} #{first_name} #{middle_name}")
    end
    teachers_list.uniq!
  end

  private

  SCHEDULE_URL = 'http://www.bsuir.by/schedule/rest/schedule/'
  STUDENTS_URL = 'http://www.bsuir.by/schedule/rest/studentGroup'

  def get_group_id(group_number)
    group_id = nil
    mechanize = Mechanize.new
    groups_page = mechanize.get(STUDENTS_URL)
    groups_page.search('studentGroup').each do |group|
      if group_number == group.search('name').text
        group_id = group.search('id').text
        break
      end
    end
    group_id
  end

  def generate_link_to_schedule(group_number)
    SCHEDULE_URL + get_group_id(group_number)
  end
end
