require 'mechanize'
require 'colorize'

class TeacherListFetcher
  attr_reader :teacher_list

  def initialize(group_number)
    @group_number = group_number
    @teacher_list = []
  end

  def parse_list
    @teacher_list.uniq!
    @teacher_list.map! do |i|
      i.split(' ')[8..-1].join(' ')
    end
    if @teacher_list.empty?
      puts 'некорректный номер группы'.red
      exit
    end
  end

  def get_list
    agent = Mechanize.new
    link = "http://www.bsuir.by/schedule/schedule.xhtml?id=#{@group_number}"
    page = agent.get(link)
    page.links_with(:href => /schedule/).each do |i|
      temp = i.click
      @teacher_list << temp.parser.css('//span.h2').text
    end
    parse_list
  rescue
    puts 'bad network connection'.red
    exit
  end
end
