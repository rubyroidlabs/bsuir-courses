class Finder
  def initialize(string, file, number_of_strings, gzip)
    @string = string
    @numb = number_of_strings
    fail 'File not found' unless File.exist?("#{file}")
    if gzip
      Zlib::GzipReader.open("#{file}") do |x|
        @text = x.readlines
      end
    else
      file_temp = File.open("#{file}")
      @text = file_temp.to_a
      file_temp.close
    end
  end

  def search
    @text.each_index do |i|
      next if @text[i][@string].nil?
      min = i - @numb
      min = 0 if min < 0
      max = i + @numb
      max = @text.size - 1 if max >= @text.size
      puts @text[min..max]
    end
  end
end
