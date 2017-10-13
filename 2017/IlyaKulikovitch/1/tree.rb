require 'rubygems'
require 'json'
@list = []
@n = 0
def parse(arr, level = 0)
  if level > @n
  @n = level
  end
  left = arr[0]
  right = arr[1]
  if left.is_a?(Integer) && right.is_a?(Array)
    str = @list[level].to_s + " " + left.to_s
    @list[level] = str
    parse(right, level + 1)
  elsif left.is_a?(Array) && right.is_a?(Array)
    parse(left, level)
    parse(right, level)
  else
    str = @list[level].to_s + " " + left.to_s + " " + right.to_s
    @list[level] = str
  end
end
def show(arr)
  lvl = 1
    arr.each do |e|
      puts
      print "[#{lvl} lvl] "
      puts e
      lvl += 1
    end
end
  name_file = "trees/#{ENV["NAME"]}.tree"
   if ENV["NAME"] == nil
     puts "Безымянных деревьев у нас не растет."
     forest = []
       Dir.foreach('trees') do |filename|
       forest << filename if filename =~ /\.tree$/
       end
     forest.sort!
     forest.each do |filename|
     puts filename
     name_file = 'trees/' + filename
     tree = File.read(name_file)
     tree = JSON.parse(tree)
     parse(tree)
     show(@list)
     puts
     print 'Желаете продолжить? [y/n] '
     answer = gets.chomp
       while(answer != 'n' || answer != 'y')
         if answer == 'y' || answer == 'n'
           break
         else print 'Желаете продолжить? [y/n] '
         end
         answer = gets.chomp
       end
     break puts 'Спасибо что были в нашем лесу.' if answer == 'n'
     end
   elsif !File.exist? name_file
     puts 'Данное дерево не растет в данном лесу.'
   else
     content = File.read(name_file)
     tree = JSON.parse(content)
     parse(tree)
     show(@list)
   end
