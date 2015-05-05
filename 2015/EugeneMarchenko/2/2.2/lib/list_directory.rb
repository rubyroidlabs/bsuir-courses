class ListDirectory
  def list(pattern)
    result =[]
    if pattern.size == 1
      puts "Pattern size: 1"
      pattern = pattern.join
      Dir.entries(pattern).each do |item|
        # p item
        next if item == '.' or item == '..' or File.directory?(item)
        p item
        result << File.realpath(item)
      end
    else
      puts "Pattern size: >1"
      pattern.each do |item|
        next if item == '.' or item == '..' or File.directory?(item)
        result << File.realpath(item)
      end
    end
    result
  end
end