require 'colorize'

class Visualizer
  def visualize_result(result)
    print "#{result}".colorize(:green)
  end

  def visualize_file_name(file)
    puts "Processing file: #{file}".colorize(:yellow)
  end

  # def visualize_patterns_around(string)
  #
  # end

  def visualize_nothing_found
    puts 'Nothing found'.colorize(:red)
  end
end