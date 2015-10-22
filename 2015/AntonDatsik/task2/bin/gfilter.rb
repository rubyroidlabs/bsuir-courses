Dir['../lib/*.rb'].each { |file| require file }
require 'optparse'

PAGE_URL = 'https://rubygems.org/gems/'
CSS_STR  = 'div.versions a.t-list__item'

class GemFilter
  def self.print_versions(arguments)
    require_gem = arguments[0]
    require_versions = arguments[1..arguments.length - 1]

    puts 'Please wait...'
    begin
      available_versions = Page.new(PAGE_URL + require_gem).get_vertsions(CSS_STR)
    rescue StandardError
      puts 'Connection error!'
      exit
    end

    suitable_versions = Filter.filter_versions(require_versions, available_versions)

    Printer.print(suitable_versions, available_versions)
  end
end

if ARGV.length < 2
  puts 'Wrong number of parameters'
  exit
end

parser = OptionParser.new do |opts|
  opts.banner = 'Usage: ./gemfiler [name_of_gem] [conditions_of_filtration]'
end
arguments = parser.parse!

GemFilter.print_versions(arguments)
