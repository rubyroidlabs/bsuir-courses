def spaces(maxlvl, curlvl)
  a = 2**(maxlvl - curlvl + 1) - 2
  ' ' * a
end

def add_str(str, maxlevel, lvl, slashline)
  str[0] += spaces(maxlevel, lvl)
  slash = (2**(maxlevel - lvl + 1) - 2) / 2
  buf = spaces(maxlevel, lvl)
  buf[slash] = slashline
  str[1] += buf
end

def paste_into_str(str, first = '  ', second = '  ')
  str[0] += first
  str[1] += second
  true
end

def tree_finder(a)
  tree = BinaryTree.new(a[0], 1)
  tree.create_tree(a, 1)
  tree.max = 0
  tree.max_depth(tree)
  tree.fake_it(tree.max)
  tree
end

def what_to_do(sum, max)
  if sum > 5000
    puts "\nОбрезать это дерево!"
  elsif max > 5
    puts "\nЭто дерево слишком высокое, срубить его! " \
    'Его высота = ' + max.to_s
  else
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
        a = entry.get_input_stream.read
        a = JSON a
        tree = tree_finder(a)
        tree.print_tree(tree.max)
        what_to_do(tree.sumelements(a), tree.max)
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
