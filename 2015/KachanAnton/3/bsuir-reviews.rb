Dir['./lib/*.rb'].each { |f| require(f) }
require 'optparse'

parser = OptionParser.new do |opts|
  opts.banner = "Usage: ./bsuir-reviews.rb [group_number]
  Examples: ./bsuir-reviews.rb 350504"
  opts.on('-h', '--help', 'Output help') do
    puts opts
    exit
  end
end
parser.parse!
group_number = ARGV[0]
if group_number == nil
  puts parser
  exit
end
lectors = GroupLectors.new(ARGV[0]).get_list
lectors_comments = LectorsComments.new(lectors).get_comments
Output.new(lectors_comments).output
