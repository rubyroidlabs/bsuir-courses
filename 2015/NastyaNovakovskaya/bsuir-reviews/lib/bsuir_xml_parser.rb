require_relative 'teacher.rb'
require 'curb'
require 'nokogiri'

class BsuirXmlParser
  def self.get_teachers_information(name)
    teachers = Array.new

    get_group_id(name)

    timetable = Curl::Easy.perform('http://www.bsuir.by/schedule/rest/schedule/'.concat(@id)).body_str
    xml_doc = Nokogiri::XML(timetable)
    teacher_elements = xml_doc.xpath('//employee')

    teacher_elements.each do |teacher|
      teachers.push(parse_teacher_element(teacher))
    end

    teachers
  end

private

  def self.get_group_id(name)
    begin
    groups_xml = Curl::Easy.perform('http://www.bsuir.by/schedule/rest/studentGroup').body_str
    rescue Curl::Err::HostResolutionError
      fail 'Нет подключения к интернету'
    end
    xml_doc = Nokogiri::XML(groups_xml)

    begin
    group_element = xml_doc.xpath("//studentGroup/*[text() = '#{name}']").first.parent
    rescue NoMethodError
      fail 'Группа не найдена.'
    end

    group_element.children.each do |child|
      if child.name == 'id'
        @id = child.text
      end
    end
  end

  def self.parse_teacher_element(element)
    teacher = Teacher.new
    element.children.each do |child|
      case child.name
      when 'firstName'
        teacher.name = child.text
      when 'lastName'
        teacher.surname = child.text
      when 'middleName'
        teacher.patronymic = child.text
      when 'academicDepartment'
        teacher.department = child.text
      end
    end
    teacher.get_comments!
    teacher
  end
end
