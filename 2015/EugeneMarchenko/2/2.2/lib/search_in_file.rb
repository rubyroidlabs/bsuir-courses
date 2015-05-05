require_relative 'visusualizer'

class SearchInFile
  def initialize(pattern, file_name)
    @pattern = pattern
    @file_name = file_name
  end

  def simple_search
    p @file_name
    @file_name.each do |item|
      File.open(item) do |f|
        f.each do |line|
          Visualizer.new.visualize(line) if line.match @pattern
        end
      end
    end
  end
end

