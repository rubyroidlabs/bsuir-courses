class ExplorerRoute
  def initialize(count, regexp, array, find_text)
    count ? @count = count : @count = 0
    @regexp = regexp
    @array = array
    @find_text = find_text
    @output_array = []
  end

  def find
    index = []
    @array.each_with_index.select do |element, i|
      unless @find_text.nil?
        index << i if element.include? @find_text
      end
      unless @regexp.nil?
        index << i if @regexp.match(element.to_s)
      end
    end

    index.uniq.each do |i|
      (i - @count) >= 0 ? from = i - @count : from = 0
      (i + @count) < @array.size ? before = i + @count : before = @array.size - 1
      @output_array << @array[from..before]
    end

    @output_array
  end
end
