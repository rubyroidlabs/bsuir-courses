#!/usr/bin/env ruby

URL_SCHEDULE = 'http://www.bsuir.by/schedule/schedule.xhtml?id='
URL_HELP = 'http://bsuir-helper.ru/search/node/'

Dir['./lib/*.rb'].each { |f| require(f) }

data = Check.new(ARGV)
data.size
data.correct
bsuir = Geter.new

begin
  teachers = bsuir.get_bsuir("#{URL_SCHEDULE}#{data.group[0]}")
rescue StandardError
  puts 'Check you internet connection'
  exit
end

data.found(teachers)

url_reviews = teachers.map do |teacher|
bsuir.search_helper("#{URL_HELP}#{teacher}")
end

reviews = url_reviews.map do |comm|
bsuir.get_reviews(comm)
end

analyz = reviews.map { |i| Analyzer.new(i) }

reviews_comm = analyz.map &:reviews_comments
reviews_teach = analyz.map &:reviews_teacher

Visualiser.new(teachers, reviews, reviews_comm, reviews_teach).visualise
