require 'json'
require 'pry'

class Tree

  attr_accessor :file_name, :data

  def main

    links = []
    sol=''

    file = Dir['./trees/*.tree']
    file.each do |file_name|
      links << file_name unless File.directory? file_name
    end

    if ENV['NAME'].nil?
      links.each do |file_name|
        read(file_name)
        print 'Желаете продолжить? [y\n]'
        sol = gets.chomp
        binding.pry
        break if sol == 'n'
      end
    elsif ENV['NAME']
      links.each do |file_name|
        if file_name.nil?
          puts 'Безымянных деревьев у нас не растет!'
          break
        end
        if file_name.include? ENV['NAME']
          read(file_name)
          binding.pry
        else
          next
        end
      end
    end
  end

  def read(file_name)
    @name = File.basename(file_name)
    @tree =JSON.parse(File.read(file_name))
    @tree
  end

end

Tree.new.main
puts 'Спасибо, что были в нашем лесу!'

