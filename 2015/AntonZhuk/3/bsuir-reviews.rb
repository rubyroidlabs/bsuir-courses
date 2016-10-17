require_relative 'names_parser'
require_relative 'print'
require_relative 'comment_parser'
require_relative 'group_parser'
require 'mechanize'

group_number = GroupParser.new
group_number.parse_options
group_number.config[:help]
num = group_number.cli_arguments

if num.empty? # Пока не разобрался, как нормально обработать строку без аргументов
  puts " -h, --help Take this example of input: 'bsuir-reviews.rb 322401'"
  exit(0)
end

name_parser = NamesParser.new(num.join.to_i)

comment_parser = CommentParser.new(name_parser.fetch_names)

Print.new(comment_parser.find_lector).print_data
