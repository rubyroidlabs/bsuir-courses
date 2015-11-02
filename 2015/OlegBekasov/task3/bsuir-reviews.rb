#!/usr/bin/env ruby
require 'optparse'
Dir[File.expand_path(('./../*.rb'), __FILE__)].each { |file| require file }
class Parser
  def self.parse(options)
    opt_parser = OptionParser.new do |opts|
      opts.banner = 'Usage: ./bsuir-reviews.rb [group]'
      opts.on('-h', '--help', 'Show help') do
        puts opts
        exit
      end
    end
    opt_parser.parse!(options)
  end
end
Parser.parse %w[--help] if ARGV.size == 0
Parser.parse(ARGV)
names = NamesParse.new(ARGV[0]).parse
reviews = ReviewsParse.new(names).parse
ReviewsPrint.new(reviews).show_reviews
