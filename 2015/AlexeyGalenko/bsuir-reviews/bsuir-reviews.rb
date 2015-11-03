require_relative 'lecturer.rb'
require_relative 'opinion.rb'
require_relative 'show.rb'
require 'slop'

begin
  opts = Slop.parse do |o|
    o.on '--help' do
      puts 'Usage'
      puts './bsuir-reviews group_number'
      puts 'for example ./bsuir-reviews 250501'
      exit
    end
  end
  a = opts.arguments

  names = Lecturer.new(a[0]).names
  if names.empty?
    puts 'for help' 
    puts 'group does not exist' 
    puts 'for help'
    puts opts
  else
    O = Opinion.new(names)
    O.links_to_opinions
    opinions = O.opinions
    Show.new(names, opinions).show
  end
rescue => e
  puts e
end
