#!/usr/bin/env ruby
Dir['../lib/*.rb'].each { |f| require_relative(f) }
require 'colorize'
require 'optparse'

OptionParser.new do |opts|
  opts.banner = 'usage: bsuir-reviews [group number]'

  opts.on('-help') do
    puts 'usage: bsuir-reviews [group number]'
    exit
  end
end.parse!

begin
  tf = TeacherListFetcher.new(ARGV[0])
  tf.get_list
  cf = CommentFetcher.new
  ya = YmlAnalysis.new

  tf.teacher_list.each do |o|
    puts o.blue
    puts '====='
    begin
      cf.get_comments(o).each do |i|
        if ya.analyze(i) == :positive
          puts i.green
        elsif ya.analyze(i) == :negative
          puts i.red
        elsif ya.analyze(i) == :neutral
          puts i.white
        end
      end
      rescue

    end
  end
end
