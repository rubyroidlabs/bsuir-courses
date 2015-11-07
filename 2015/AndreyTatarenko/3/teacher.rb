require 'rubygems'
require 'mechanize'

class Teacher
  def initialize(group)
    @url_bsuir = 'http://www.bsuir.by/schedule/schedule.xhtml?id='.concat(group)
    @url_helper = 'http://bsuir-helper.ru/lectors'
    @agent = Mechanize.new
    @all_teachers = []
  end

  def list
    @page = @agent.get(@url_bsuir)
    @page.links.each {|link| @all_teachers << link.text}
    @all_teachers = @all_teachers[3..-6]
    @all_teachers.uniq!
  end

  def initials(teacher)
    @teacher_initials = teacher.split(' ')
    @teacher_initials = @teacher_initials[0].concat(' ').concat(@teacher_initials[-2][0]).
        concat('.').concat(' ').concat(@teacher_initials[-1][0]).concat('.')
  end

  def links
    @page = @agent.get(@url_helper)
    @link_list = @page.links.map {|link| link.text}
    @teachers_links = @link_list[@link_list.index('') + 1 .. -1]
  end

end