#!/usr/bin/env ruby
Dir['bsuir-reviews/*.rb'].each { |file| require_relative file }
require 'mechanize'

class BsuirReviewer
  BSUIR_HELPER_URL = 'http://bsuir-helper.ru'
  XPATH_DATE = "/html/body/div[@id='page']\
               /div[@id='main-wrapper']/div[@id='main']\
               /div[@id='content-wrapper']/div[@id='content']\
               /div[@id='content-inner']/div[@id='content-content']\
               /div[@id='comments']/div[@class='rounded-outside']\
               /div[@class='rounded-inside']\
               /div[@class='comment odd clear-block']\
               /div[@class='submitted']/span[@class='comment-date']"

  XPATH_TEXT = "/html/body/div[@id='page']\
               /div[@id='main-wrapper']/div[@id='main']\
               /div[@id='content-wrapper']/div[@id='content']\
               /div[@id='content-inner']/div[@id='content-content']\
               /div[@id='comments']/div[@class='rounded-outside']\
               /div[@class='rounded-inside']\
               /div[@class='comment odd clear-block']\
               /div[@class='content']/p"

  def initialize
    group_number = ConsoleParser.new.parse_console_param(ARGV)
    @group_employees, @all_employees = Parser.new(group_number).parse
    @agent = Mechanize.new
    @sentiment_analizator = SentimentAnalizator.new
  end

  def review_employees
    @group_employees.each do |e|
      puts e
      puts '==============='
      if @all_employees.keys.include? e
        search_comments(e)
      else
        puts "Нет на сайте\n\n"
      end
    end
  end

  def search_comments(employee)
    page = @agent.get("#{BSUIR_HELPER_URL}#{@all_employees[employee]}")
    comments_date = page.search(XPATH_DATE).map(&:text)
    comments_text = page.search(XPATH_TEXT).map(&:text)
    comments = Hash[comments_date.zip comments_text]
    if comments.empty?
      puts "Нет отзывов\n\n"
    else
      print_comments(comments)
    end
  end

  def print_comments(comments)
    comments.each do |date, text|
      rating = @sentiment_analizator.analyze(text)
      if rating > 0
        color = :green
      elsif rating < 0
        then color = :red
      else
        color = :white
      end
      Writer.write("#{date} : #{text}\n\n", color)
    end
  end
end

BsuirReviewer.new.review_employees
