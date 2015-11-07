require 'rubygems'
require 'colorize'
require 'optparse'
require 'httparty'

class ArgParser
  def initialize(args)
    @all_groups_page = 'http://www.bsuir.by/schedule/allStudentGroups.xhtml'
    @args = args
    @args << '-h' if @args.empty?
  end

  def parse
    @args = option_parser(@args)
    @args = group_parser(@args)
    @args.first.to_s
  end

  def option_parser(args)
    opt_parser = OptionParser.new do |opts|
      opts.banner = 'Usage: ./bsuir-reviews [group]'
      opts.on_tail('-h', '--help', 'Example: ./bsuir-reviews 451006') do
        puts opts
        exit
      end
    end
    begin
      opt_parser.parse!(args)
    rescue OptionParser::InvalidOption => error
      puts error
      puts opt_parser
      exit
    end
    args
  end

  def group_parser(args)
    abort('Input just one group'.red) unless args.size == 1
    begin
      page = HTTParty.get(@all_groups_page).to_s
    rescue SocketError
      puts 'Cannot connect to Internet'
      exit
    end
    all_groups = page.scan(/(?<=группы ).+(?=<)/)
    abort('Incorrect group'.red) unless all_groups.include?(args.first.to_s)
    args
  end
end