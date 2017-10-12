def numeric?(obj)
  !obj.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/).nil?
end

def spaces(maxlvl, curlvl)
  a = 2**(maxlvl - curlvl + 1) - 2
  ' ' * a
end

def tree_finder(entry)
  a = entry.get_input_stream.read
  a = JSON a
  tree = BinaryTree.new(a[0], 1)
  tree.create_tree(a, 1)
  tree.max = 0
  tree.max_depth(tree)
  tree.fake_it(tree.max)
  tree
end

def what_to_do(sum, max)
  checker = 0
  if sum > 5000
    checker += 1
    puts "\nОбрезать это дерево!"
  end
  if max > 5 && checker.zero?
    puts "\nЭто дерево слишком высокое, срубить его! " \
    'Его высота = ' + max.to_s
    checker += 1
  end
  if checker.zero?
    puts "\nЭто дерево и не слишком высокое и не слишком разрослось, "\
    ' оставьте его в покое.'
  end
end

def name_not_given
  Zip::File.open('trees.zip') do |zip_file|
    zip_file.each do |entry|
      if entry.directory?
        puts 'Добро пожаловать в наш лес!'
      else
        puts entry.name
        tree = tree_finder(entry)
        tree.print_tree(tree.max)
        what_to_do(tree.sum_elements, tree.max)
        puts "\nХотите продолжить? [y/n]: "
        e = gets.to_s
        e[0] = e[0].downcase
        if e[0] == 'n'
          p 'Спасибо, что были в нашем лесу!'
          break
        end
      end
    end
  end
end
