#!/usr/bin/env ruby
require_relative 'bsuir-reviews/parser.rb'
require_relative 'bsuir-reviews/writer.rb'
require_relative 'bsuir-reviews/sentiment_analizator.rb'
require 'mechanize'
require 'slop'

class BsuirReviewer
  BSUIR_HELPER_URL = 'http://bsuir-helper.ru'
  XPATH_DATE ="/html/body/div[@id='page']\
               /div[@id='main-wrapper']/div[@id='main']\
               /div[@id='content-wrapper']/div[@id='content']\
               /div[@id='content-inner']/div[@id='content-content']\
               /div[@id='comments']/div[@class='rounded-outside']\
               /div[@class='rounded-inside']/div[@class='comment odd clear-block']\
               /div[@class='submitted']/span[@class='comment-date']"

  XPATH_TEXT = "/html/body/div[@id='page']\
               /div[@id='main-wrapper']/div[@id='main']\
               /div[@id='content-wrapper']/div[@id='content']\
               /div[@id='content-inner']/div[@id='content-content']\
               /div[@id='comments']/div[@class='rounded-outside']\
               /div[@class='rounded-inside']/div[@class='comment odd clear-block']\
               /div[@class='content']/p"

  def initialize
    group_number = parse_console_param
    @group_employees, @all_employees = Parser.new(group_number).parse
    @agent = Mechanize.new
    @Sentiment_analizator = Sentiment_analizator.new
  end

  def review_employees
    @group_employees.each do |e|
      puts e
      puts "==============="
      if @all_employees.keys.include? e
        page = @agent.get("#{BSUIR_HELPER_URL}#{@all_employees[e]}")
        comments_date = page.search(XPATH_DATE).map(&:text)
        comments_text = page.search(XPATH_TEXT).map(&:text)
        comments = Hash[comments_date.zip comments_text]
        if comments.empty?
          puts "Нет отзывов\n\n"
        else
          print_comments(comments)
        end
      else
        puts "Нет на сайте\n\n"
      end
    end
  end

  def print_comments(comments)
    comments.each do |date, text|
      rating = @Sentiment_analizator.analyze(text)
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

  def parse_console_param
  opts = Slop::Options.new
  opts.banner = "Usage: ./bsuir-reviews.rb group_number"
  opts.on '-h', '--help' do
    puts opts.banner
    puts "Example: ./bsuir-reviews.rb 520601"
    exit
  end

  parser = Slop::Parser.new(opts)
  result = ARGV.replace parser.parse(ARGV).arguments
  fail if result.count != 1
  result[0]
  rescue => e
    puts opts
    abort()
  end

end

BsuirReviewer.new.review_employees
