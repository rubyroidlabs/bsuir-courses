Dir['../lib/*.rb'].each {|file| require file }

PAGE_URL = 'https://rubygems.org/gems/'
CSS_STR  = 'div.versions a.t-list__item'



if ARGV.length < 2 then
  puts 'Wrong number of parameters'
  exit
end
require_gem = ARGV[0]
require_versions = ARGV[1..ARGV.length - 1]

puts "Please wait..."
begin
  available_versions = Page.new(PAGE_URL + require_gem).get_vertsions(CSS_STR)
  rescue Exception => e
  puts "Connection error!"
  exit
end

suitable_versions = Filter.filter_versions(require_versions, available_versions)

Printer.print(suitable_versions, available_versions)
