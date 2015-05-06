require_relative '../lib/visualizer'

class SearchInFile
  def initialize(pattern, file_names)
    @pattern = pattern
    @file_names = file_names
    @v = Visualizer.new
  end

  def simple_search
    @file_names.each do |item|
      @v.visualize_file_name(item)
      File.open(item) do |f|
        f.each do |line|
          @v.visualize_result(line) if line.match @pattern
        end
      end
    end
  end

  def search_around(around_number)
    @file_names.each do |item|
      line_counter = 0
      pattern_line = around_number
      @v.visualize_file_name(item)
      File.open(item) do |f|
        f.each do |line|
          line_counter += 1
          if line.match @pattern
            while pattern_line > 0
              puts line[line_counter - pattern_line]
              pattern_line += 1
            end
            @v.visualize_result(line)
          end
        end
      end
    end
  end
end

