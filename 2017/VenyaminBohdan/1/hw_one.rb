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

if ENV['NAME'] == nil
  puts "There are no nameless trees here"
else
  file_count = 0
  Dir.foreach("trees") do |file|
    if ENV['NAME'] + '.tree' == file
      puts file
      FunctionReturn(FileOpen(file))
      file_count += 1
    end
  end

  if file_count == 0
    puts "There are no trees with this name"
  end
end

