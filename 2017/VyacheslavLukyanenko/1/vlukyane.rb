require 'rubygems'
require 'zip'
require "json"

name = ENV["NAME"]

def is_number? string
  true if Float(string) rescue false
end

def buildTreeDivideAndConquer(treeArray, levelOfDepth, branchDir)

  l = treeArray[0]
  r = treeArray[1]
  @maximalDepth = levelOfDepth > @maximalDepth? levelOfDepth : @maximalDepth
  if (l.is_a?(Integer))
    @a[levelOfDepth].push([l, branchDir])
    @vertexSum += l
    levelOfDepth += 1
  end

  if (r.is_a?(Integer))
    if l.is_a?(Integer)
       levelOfDepth -= 1
    end
    @a[levelOfDepth].push([r, branchDir])
    @vertexSum += r
  end

  if (l.is_a?(Array))
    buildTreeDivideAndConquer(l, levelOfDepth, 'l')
  end

  if (r.is_a?(Array))
    buildTreeDivideAndConquer(r, levelOfDepth, 'r')
  end

end

def buildPrintTree()
  19.times do
    @a.push([])
  end
end

def printTree()
  n = @maximalDepth
  (0..2*(2**(n-1))).each do |i|
    print ' '
  end
  print @a[1][0][0]
  puts

  (1 .. n - 1).each do |i|
    str = String.new("")
    count = 0
    #Вывод значений
    (1..(2**(n-i)-1)).each do
      str += ' '
    end
    str += @a[i + 1][count][0].to_s
    count += 1
    k = 1
    (1 .. (2**i)-1).each do
      (1..2**(n-i+1) - 1).each do
        str += ' '
      end
      if (k == 0)
        str += @a[i + 1][count][0].to_s
        count += 1
        k = 1
      else
        str += @a[i + 1][count][0].to_s
        count += 1
        k = 0
      end
    end

    flag = false
    k = 0
    calc = 0
    str.split("").each do |i|
      if (is_number?(i)) && !flag
        if (k == 0)
          print"/"
          k = 1
        else
          print "\\"
          k = 0
        end
        flag = true
      elsif (is_number?(i) && flag)
        print ' '
      elsif (i == ' ')
        print ' '
        calc += 1
        flag = false
      end
    end
    puts
    puts str
  end
end

def makeChoise()
  puts
  if @vertexSum > 5000
    puts "Срубить"
  elsif @maximalDepth > 5
    puts "Обрезать"
  else
    puts "Оставить его как есть"
  end
end


def level3()
  Zip::File.open('trees.zip') do |zip_file|
    zip_file.each do |entry|
      if !entry.directory?
        puts entry.name
        content = entry.get_input_stream.read
        @a = []
        buildPrintTree()
        @vertexSum = 0
        @maximalDepth = 0
        parsedJsonTree = JSON.parse(content)
        buildTreeDivideAndConquer(parsedJsonTree, 1, 'c')
        printTree()
        makeChoise()
        puts "\nХотите продолжить? [y/n]: "
        userAns = gets.to_s
        userAns[0] = userAns[0].downcase
        if userAns[0] == 'n'
          p 'Спасибо, что были в нашем лесу!'
          break
        end
      end
    end
  end
end


# =>                                           BEGINNING

::Zip.sort_entries = true
puts "Добро пожаловать в наш лес!"
name = ENV["NAME"]
if (name.nil?)
  level3
else
  Zip::File.open('trees.zip') do |zip_file|
    if zip_file.find_entry("trees/#{name}.tree")
      content = zip_file.read("trees/#{name}.tree")
      @a = []
      buildPrintTree()
      @vertexSum = 0
      @maximalDepth = 0
      parsedJsonTree = JSON.parse(content)
      buildTreeDivideAndConquer(parsedJsonTree, 1, 'c')
      printTree()
    else
      puts "Данное дерево тут не растёт!"
    end
    puts "Спасибо, что были в нашем лесу!"
  end
end
