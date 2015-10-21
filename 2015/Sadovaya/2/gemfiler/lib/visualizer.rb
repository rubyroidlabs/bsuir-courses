require 'colorize'

class Visualizer
  def visualize(hash, name)
    hash.each_pair do |version, flag|
      if flag
        puts "#{name} (#{version})".colorize(:red)
      else 
        puts "#{name} (#{version})"
      end
    end
  end
end
