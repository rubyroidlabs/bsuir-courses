require_relative './tree_parser'
require_relative './tree_printer'
MAX_DEPTH = 5
MAX_SUM = 5000
# frozen_string_literal
CONTINUE_STATUS = 'y'.freeze
# frozen_string_literal
STOP_STATUS = 'n'.freeze

def print_tree(name)
  path = "./trees/#{name}"
  json_tree = File.read(path)
  tree_parser = TreeParser.new(json_tree)
  parsed_tree = tree_parser.parse_layers
  tree_printer = TreePrinter.new(parsed_tree)
  puts '', name
  puts tree_printer.render
  if parsed_tree.count > MAX_DEPTH || parsed_tree.flatten.sum > MAX_SUM
    puts '', 'Срубить.'
  else
    puts '', 'Оставить.'
  end
  print "\nЖелаете продолжить? [y/n] "
end

def continue?
  user_answer = gets.chomp

  if user_answer == STOP_STATUS
    abort 'Спасибо что были в нашем лесу'
  elsif user_answer == CONTINUE_STATUS
    return
  else
    continue?
  end
end

tree_names =
  Dir.entries('./trees')
     .delete_if { |filename| filename == '.' || filename == '..' }.sort!
tree_names.each do |tree_name|
  print_tree(tree_name)
  continue?
end

puts 'Спасибо что были в нашем лесу'
