require_relative './tree_parser'
require_relative './tree_printer'
MAX_DEPTH = 5
MAX_SUM = 5000
CONTINUE_STATUS = 'y'.freeze
STOP_STATUS = 'n'.freeze

def print_tree(name)
  path = "./trees/#{name}"
  json_tree = File.read(path)
  tree_parser = TreeParser.new(json_tree)
  parsed_tree = tree_parser.get_layers
  tree_printer = TreePrinter.new(parsed_tree)
  puts '', name
  puts tree_printer.render
  if parsed_tree.count > MAX_DEPTH || tree_parser.sum > MAX_SUM
    puts '', 'Срубить.'
  else
    puts '', 'Оставить.'
  end
  puts
  print 'Желаете продолжить? [y/n] '
end

tree_names =
  Dir.entries('./trees')
      .delete_if { |filename| filename == '.' || filename == '..' }.sort!

iterator = 1
print_tree(tree_names[0])
while iterator != (tree_names.count - 1)
  user_answer = gets.chomp
  if user_answer == CONTINUE_STATUS
    print_tree(tree_names[iterator += 1])
  elsif user_answer == STOP_STATUS
    abort 'Спасибо что были в нашем лесу'
  end
end

puts 'Спасибо что были в нашем лесу'
