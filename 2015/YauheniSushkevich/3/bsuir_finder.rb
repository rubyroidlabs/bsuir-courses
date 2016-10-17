require 'cyrillizer'
require 'open-uri'
require 'nokogiri'

# Finds group id by group number,
# group's teachers by group id using BSUIR schedule API
# and teacher's comments using BSUIR-helper site
class Finder
  GROUPS_URL = 'http://www.bsuir.by/schedule/rest/studentGroup'
  SCHEDULE_URL = 'http://www.bsuir.by/schedule/rest/schedule/'
  LECTORS_URL = 'http://bsuir-helper.ru/lectors'
  BSUIR_HELPER_URL = 'http://bsuir-helper.ru'
  Cyrillizer.language = :russian

  def self.find_group_id(number)
    group_id = nil
    groups = Nokogiri::XML(open GROUPS_URL)
    groups.xpath('//studentGroup').each do |group|
      group_id = group.xpath('id').text.to_i if group.xpath('name').text == number
    end
    group_id
  end

  def self.parse_teacher(employee)
    teacher = {}
    teacher[:last_name] = employee.xpath('lastName').text
    teacher[:latin_last_name] = employee.xpath('lastName').text.to_lat
    teacher[:first_name] = employee.xpath('firstName').text
    teacher[:middle_name] = employee.xpath('middleName').text
    teacher[:comments] = []
    teacher
  end

  def self.find_teachers(group_id)
    teachers = []
    schedule = Nokogiri::XML(open(SCHEDULE_URL + group_id.to_s))
    schedule.xpath('//employee').each do |employee|
      teacher = parse_teacher employee
      teachers << teacher
    end
    teachers.uniq!
  end

  def self.find_teachers_url(teacher)
    page = Nokogiri::HTML(open LECTORS_URL)
    references = page.xpath('//a')
    url = nil
    references.each do |reference|
      url = reference.values.first if reference.text.split.join(' ') == "#{teacher[:last_name]} #{teacher[:first_name]} #{teacher[:middle_name]}"
    end
    url
  end

  def self.find_comments(teacher)
    teacher_comments = []
    url = find_teachers_url teacher
    unless url.nil?
      page = Nokogiri::HTML(open(BSUIR_HELPER_URL + url))
      times = page.xpath("//div[@class='rounded-inside']/div/div[@class='submitted']/span[@class='comment-date']")
      comments = page.xpath("//div[@class='rounded-inside']/div/div[@class='content']/p")
      times.each_with_index do |time, index|
        teacher_comments << { time: time.text, text: comments[index].text }
      end
    end
    teacher_comments
  end
end
