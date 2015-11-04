require_relative 'schedule_parser'

class HelperParser
  attr_reader :comments_hash
  def initialize(group_number)
    @lecturers = ScheduleParser.new(group_number).lecturers
    @comments_hash = get_comments
    add_default_comment
    @comments_hash
  end

  def get_comments
    hash = {}
    page = Mechanize.new.get('http://bsuir-helper.ru/lectors')
    page.links.each do |link|
      if @lecturers.include?(link.text.gsub(/\s+/, ' '))
        hash[link.text] = link.click.search('div.comment').map do |l|
          l.search('div.content p').to_s.gsub(/<.*?>/, '')
        end
      end
    end
    hash
  end

  def add_default_comment
    @lecturers.each do |lecturer|
      unless @comments_hash.keys.include?(lecturer)
        @comments_hash[lecturer] = ['Нет информации']
      end
    end
  end
end
