require 'zip'
require 'json'
require_relative 'tree_hash'

CUT_SUM = 5000
TRIM_DEPTH = 5

# environment variable NAME='tree_name'
name = ENV['NAME']

if name
  Zip::File.open('trees.zip') do |zip_file|
    if zip_file.find_entry("trees/#{name}.tree")
      arr = JSON.parse(zip_file.read("trees/#{name}.tree"))
      tree = TreeHash.new(arr)
      puts name + '.tree'
      puts tree
      if tree.sum > CUT_SUM
        puts 'Срубить.'
      elsif tree.depth > TRIM_DEPTH
        puts 'Обрезать.'
      else
        puts 'Оставить.'
      end
    else
      puts 'Данное дерево не растет в данном лесу.'
    end
  end
else
  trees = 0
  trim = 0
  cut = 0
  leave = 0
  Zip::File.open('trees.zip') do |zip_file|
    zip_file.glob('trees/*.tree').sort_by(&:name).each do |entry|
      arr = JSON.parse(entry.get_input_stream.read)
      tree = TreeHash.new(arr)
      trees += 1
      puts entry.name
      puts tree
      if tree.sum > CUT_SUM
        puts 'Срубить.'
        cut += 1
      elsif tree.depth > TRIM_DEPTH
        puts 'Обрезать.'
        trim += 1
      else
        puts 'Оставить.'
        leave += 1
      end
      puts 'Желаете продолжить? [y/n]'
      q = gets
      break if q[0, 1] == 'n'
    end
    puts 'Мы обработали ' + trees.to_s + ' деревьев, из них:'
    puts '-- оставили ' + leave.to_s
    puts '-- обрезали ' + trim.to_s
    puts '-- срубили ' + cut.to_s
    puts 'Спасибо что были в нашем лесу'
  end
end
