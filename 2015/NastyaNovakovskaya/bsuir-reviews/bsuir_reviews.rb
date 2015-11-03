#!/usr/local/bin/ruby
require 'optparse'
require './lib/group_teachers.rb'
require 'colorize'

def print_help
  help_string = File.read('./config/help')
  puts help_string
end

parser = OptionParser.new do|opts|
      opts.banner = 'Usage: bsuir_reviews.rb [options]'
      opts.on('-h') do
        print_help
        exit
      end
    end
parser.parse!
group_name = ARGV[0]

if group_name.nil?
  print_help
else
  group = GroupTeachers.new(group_name)
  group.print_result
end
