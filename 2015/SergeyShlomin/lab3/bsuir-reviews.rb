#!/usr/bin/env ruby
require 'optparse'
require 'colored'
require 'mechanize'
require 'libxml'
require 'yaml'
require 'unicode'

begin
  Dir[File.expand_path('..', __FILE__) + '/lib/*.rb'].each do |f|
    require_relative f
  end
  options = {}
  parser = OptionParser.new do |opts|
    opts.banner = 'Usage: ./bsuir-reviews.rb [option] [group number]
      Example:  ./bsuir-reviews.rb 351001
      ./bsuir-reviews.rb -h, --help to get help'
    opts.on('-y', '--yaml', 'yaml') do
      options[:yaml] = true
    end
    opts.on('-n', '--neural', 'Neural network') do
      options[:neural] = true
    end
    opts.on('-h', '--help', 'help') do
      puts opts
    end
  end
  parse_argv = parser.parse!
  if parse_argv.empty? || parse_argv.count > 1
    fail ArgumentError.new 'Input argument error'
  else
    agent = Mechanize.new
    agent.user_agent_alias = 'Mac Safari'
    procc = Proc.new do |analyzer|
      bsuir_lectors = BsuirLectors.new(agent, parse_argv[0]).lectors
      lectors_reviews = BsuirhelperReviews.new(agent, bsuir_lectors).lector_reviews
      Printer.new(analyzer, lectors_reviews).print
    end
    case
    when options[:yaml]
      analyzer = Analyzer.new
      procc.call(analyzer)
    when options[:neural]
      puts 'это пока еще не реализовано, воспользуйтесь опцией -y'
    else
      analyzer = Analyzer.new
      procc.call(analyzer)
    end
  end
rescue ArgumentError => e
  puts 'ArgumentError'
  if e.message == 'Input argument error'
    puts 'Неверно указаны входные параметры, воспользуйтесь шаблоном ниже'
    puts parser.banner
  else
    e.message
  end
rescue NameError => e
  puts 'NameError'
  puts e.message
rescue StandardError => e
  p e.message
end
