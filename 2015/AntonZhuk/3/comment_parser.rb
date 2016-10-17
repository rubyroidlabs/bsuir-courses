require 'rubygems'
require 'mechanize'

class CommentParser
  def initialize(names)
    @names = names
  end

  def find_lector
    @lectors = Hash.new
    @agent = Mechanize.new
    begin
      page = @agent.get('http://bsuir-helper.ru/lectors')
    rescue => e
      puts "Cannot connect to bsuir-helper.ru: #{e.message}"
    end

    lector = page.search('#content-content div div a')
    @names.each do |name|
      lector.each do |link|
        if name == convert_name(link.text)
          @lectors[name] = parse_comments(link['href'])
          if @lectors[name].empty?
            @lectors[name] = Array.[]('Comments not found!')
          end
        elsif @lectors[name].nil?
          @lectors[name] = Array.[]('Lector not found!')
        end
      end
    end
    @lectors
  end

  def parse_comments(href)
    comments = []
    begin
      page = @agent.get("http://bsuir-helper.ru/#{href}")
    rescue => e
      puts "Cannot connect to bsuir-helper.ru: #{e.message}"
    end
    page.search('#comments div.rounded-outside div div').each do |comment|
      message = comment.search('div.content')
      date = comment.search('div.submitted span.comment-date')
      comments.push(date.text + message.text)
    end
    comments
  end

  def convert_name(full_name)
    surname, name, patronymic = full_name.split
    name = name[0] + '.'
    patronymic = patronymic[0] + '.'
    surname + ' ' + name + ' ' + patronymic
  end
end
