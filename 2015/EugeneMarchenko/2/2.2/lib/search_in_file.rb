require_relative '../lib/visualizer'

class SearchInFile
  def initialize(pattern, file_names)
    @pattern = pattern
    @file_names = file_names
    @v = Visualizer.new
  end

  def simple_search
    # p @pattern
    # p true
    counter = 0
    @file_names.each do |item|
      @v.visualize_file_name(item)
      File.open(item) do |f|
        f.each do |line|
          if line.match(@pattern)
            @v.visualize_result(line)
            counter += 1
          end
        end
        @v.visualize_nothing_found if counter == 0
      end
    end
  end
end

