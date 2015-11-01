require 'mechanize'

# Class BsuirTeachers allows you to get string[]
# of teachers names by group number
class BsuirTeachers
  attr_reader :groups_id, :group

  def initialize(group)
    @group = group
  end

  def teachers_list
    groups_id_hash_get
    group_id = @groups_id[@group]
    fail ArgumentError, 'group not found' if group_id.nil?
    get_teachers_list_by_id(group_id)
  end

  private

  def get_teachers_list_by_id(id)
    names = []
    page = Mechanize.new.get("http://www.bsuir.by/schedule/rest/schedule/#{id}")
    page.search('employee').each do |employee|
      first_name = employee.search('firstName').text
      middle_name = employee.search('middleName').text
      last_name = employee.search('lastName').text
      names << "#{last_name} #{first_name} #{middle_name}"
    end
    names.uniq.sort
  end

  def groups_id_hash_get
    page = Mechanize.new.get('http://www.bsuir.by/schedule/rest/studentGroup/')
    @groups_id = {}
    page.search('//studentGroup').each do |group|
      group_name = group.search('name').text
      group_id = group.search('id').text
      @groups_id[group_name] = group_id
    end
  end
end
