require 'colorize'
class Visualizer
  def visualize_result(result)
    print "#{result}".colorize(:green)
  end

  def visualize_file_name(file)
    puts "Found in file: #{file}".colorize(:yellow)
  end

  def visualize_patterns_around(string)

  end
end