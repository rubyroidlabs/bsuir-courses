require_relative 'visusualizer'

class SearchInFile
  def initialize(pattern, file_name)
    @pattern = pattern
    @file_name = file_name
  end

  def simple_search
    if @file_name == ['.']
      file_name = @file_name.join
      # p file_name
      Dir.entries(file_name).select { |f| !File.directory? f }.each do |item|
        # p item
        next if item == '.' or item == '..'
        # p item
        File.open(item) do |f|
          f.each do |line|
            Visualizer.new.visualize(line) if line.match @pattern
          end
        end
      end
    else
      @file_name.each do |file|
        File.open(file) do |f|
          f.each do |line|
            Visualizer.new.visualize(line) if line.match @pattern
          end
        end
      end
    end
  end
end
