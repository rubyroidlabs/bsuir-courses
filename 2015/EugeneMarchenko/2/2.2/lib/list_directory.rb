class ListDirectory
  def list(pattern)
    result =[]
    if pattern == ['.'] or pattern == ['*']
      pattern = pattern.join
      # p pattern
      Dir.entries(pattern).select { |f| !File.directory? f }.each do |item|
        # p item
        next if item == '.' or item == '..'
        result << item
      end
    else
      Dir.foreach(pattern) do |file|
        p file
        # result << file
      end
    end
    result
  end
end