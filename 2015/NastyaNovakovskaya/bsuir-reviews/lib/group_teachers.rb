require_relative 'bsuir_xml_parser'

class GroupTeachers
  def initialize(name)
    @name = name
    @id = 0
    @teachers = BsuirXmlParser.get_teachers_information(@name)
    uniq_initials = Array.new
    uniq_teachers = Array.new
    @teachers.each do |teacher|
      initials = teacher.surname + teacher.name + teacher.patronymic
      if uniq_initials.index(initials).nil?
        uniq_initials.push(initials)
        uniq_teachers.push(teacher)
      end
    end

    @teachers = uniq_teachers
  end

  def print_result
    @teachers.each(&:teacher.show_information)
  end
end
