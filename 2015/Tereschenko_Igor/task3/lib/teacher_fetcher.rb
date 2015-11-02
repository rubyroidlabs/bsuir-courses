require 'mechanize'
require 'colorize'

NOT_NAMES = ['Поиск по группе', 'Расширенный поиск:', 'Печать', 'iis-support@bsuir.by',
            'Скачать Android версию расписания.', 'disp@bsuir.by', 'API', 'О нас']

class TeacherListFetcher
  attr_reader :teacher_list

  def initialize(group_number)
    @group_number = group_number
    @teacher_list = []
  end

  def parse_list
    @teacher_list.uniq!
    @teacher_list.map! do |i|
      i[0...-5]
    end
    if @teacher_list.empty?
      puts 'некорректный номер группы'.red
      exit
    end
  end

  def get_list
    agent = Mechanize.new
    page = agent.get("http://www.bsuir.by/schedule/schedule.xhtml?id=#{@group_number}")
    page.links.each do |i|
      unless NOT_NAMES.include? i.to_s.strip
        @teacher_list << i.text
      end
    end
    parse_list
  end
end
