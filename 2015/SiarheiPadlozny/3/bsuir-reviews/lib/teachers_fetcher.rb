require 'mechanize'

class TeachersFetcher
  attr_reader :teachers, :group_number
  NAME_FORMAT = /^([А-Я][А-Яа-я-]{3,30})[ ][А-Я][.][ ][А-Я][.][ ]*$/
  SCHEDULE_URL = 'http://www.bsuir.by/schedule/schedule.xhtml?id='

  def initialize(group_number)
    @group_number = group_number
    @agent = Mechanize.new
  end

  def schedule_url
    SCHEDULE_URL + @group_number
  end

  def fetch_teachers
    @agent.get schedule_url do |page|
      @teachers = page.links.map do |link|
        link.to_s if link.to_s =~ NAME_FORMAT
      end.compact.uniq
    end
    fail 'Group not found.' if @teachers.empty?
  rescue SocketError
    raise StandartError 'No Internet!'
  end
end
