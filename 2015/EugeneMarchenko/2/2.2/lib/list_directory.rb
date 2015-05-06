class ListDirectory
  def list(pattern)
    result =[]
    pattern.each do |i|
      if !File.directory?(i)
        result << Pathname.new(i).realpath.to_s
      elsif i == '.'
        Dir.entries(i.to_s).each do |item|
          next if item == '.' or item == '..' or File.directory?(item)
          result << Pathname.new(item).realpath.to_s
        end
      end
    end
    result
  end
end