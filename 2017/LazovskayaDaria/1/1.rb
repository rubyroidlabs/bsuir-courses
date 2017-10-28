require 'pry'
require 'json'




if ARGV.length != 1
    puts "Ведите ruby 1.rb, а затем имя дерева в виде name.tree"
    exit;
end
 
filename = ARGV[0]
puts "Открываем '#{filename}'"
 
file = open filename
 
# puts fh



file.each_char do |char|

puts char

 end
file.close

class Branch
def weight
@weight = array
end
def left
@left = nil
end
def right
@right = nil
end
def initialize(array)
    if array.is_a? Integer
      weight
      left
      rigth
     
    else
      @weight = array[0]
      @left = Branch.new(array[1][0])
      @right = Branch.new(array[1][1])
    end
  end
end 
