require_relative './tree_parser'
require_relative './tree_printer'

def print_tree(name)
  path = "./trees/#{name}"
  json_tree = File.read(path)
  tree_parser = TreeParser.new(json_tree)
  parsed_tree = tree_parser.get_layers
  tree_printer = TreePrinter.new(parsed_tree)
  puts
  puts name
  puts tree_printer.render
  puts
  if tree_parser.depth > 5 || tree_parser.sum > 100
    puts 'Срубить.'
  else
    puts 'Оставить.'
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
  continue_status = 'y'
  stop_status = 'n'
  user_answer = gets.chomp
  if user_answer == continue_status
    print_tree(tree_names[iterator += 1])
  elsif user_answer == stop_status
    abort 'Спасибо что были в нашем лесу'
  end
end

puts 'Спасибо что были в нашем лесу'
