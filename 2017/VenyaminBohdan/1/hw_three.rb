require 'json'

def FileOpen(way)
  file = open("/home/venya/trees/" + way)
  text = file.read
  arr = JSON.parse(text)
  arr
end

def FunctionReturn(arr)
  return if arr.class != Array
  (0..arr.length).each do |i|
    if arr[i].class == Array
      arr[i].map do |arr|
        if arr.class != Array
          print arr
        end
        puts "\n"

        FunctionReturn(arr)
      end
    else
      if arr[i] != nil
        print "#{arr[i]} - "
      end
    end
  end
end

def CompareAge(file)
  if FileOpen(file).flatten.inject(0, :+) > 5000
    puts "It's necessary to cut down this tree"
    true
  else
    false
  end
end

def DepthTree(file, depth)
  b = FileOpen(file).dup
  until b==FileOpen(file).flatten
    depth+=1
    b=b.flatten(1)
  end
  depth
end

def CompareDepth(file, depth)
  if CompareAge(file) == false
    if DepthTree(file, depth) > 5
      puts "It's necessary to trim this tree"
    else
      puts "This tree is normal!"
    end
  end
end

depth = 1
if ENV['NAME'] == nil
  Dir.entries("trees").sort!.each do |file|
    if file == "." or file == ".."
      next
    end

    puts file
    FunctionReturn(FileOpen(file))
    CompareDepth(file, depth)

    loop_test = true
    while loop_test
      print "\nOutput another tree?(y/n): "
      answer = gets.chomp
      if answer == 'y'
        puts "No problem!"
        loop_test = false
      elsif answer == 'n'
        puts "Your choice!"
        break
      else
        puts "Incorrect answer!"
      end
    end
    if answer == 'n'
      break
    end
  end
else
  file_count = 0
  Dir.foreach("trees") do |file|
    if ENV['NAME'] + '.tree' == file
      puts file
      FunctionReturn(FileOpen(file))
      CompareDepth(file, depth)
      file_count += 1
    end
  end

  if file_count == 0
    puts "There are no trees with this name"
  end
end
