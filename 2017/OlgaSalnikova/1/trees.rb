require 'pry'
require 'json'

# Class for working with tree
class Tree
  MAX_AGE = 5000
  MAX_HEIGHT = 5

  def initialize(tree)
    @tree = tree
  end

  def age
    @tree.flatten.inject(0) { |sum, element| sum + element }
  end

  def height
    depth(@tree)
  end

  def draw
    puts @tree.inspect
  end

  def cut?
    height > MAX_HEIGHT
  end

  def chop?
    age > MAX_AGE
  end

  private

  def depth(arr, level = 0)
    new_array = []
    arr.each do |node|
      new_array += node if node.is_a?(Array)
    end
    if new_array.empty?
      level + 1
    else
      depth(new_array, level + 1)
    end
  end

  class << self
    def load_from_file(file_name)
      tree = []
      File.open(file_name) do |file|
        tree = JSON.parse(file.read)
      end
      new(tree)
    end

    def load_from_file_and_check(file_name)
      tree = load_from_file(file_name)
      tree.draw
      if tree.chop?
        puts 'Срубить'
      elsif tree.cut?
        puts 'Обрезать'
      else
        puts 'Оставить'
      end
    end
  end
end

if ENV['NAME'].to_s.empty?
  puts 'Безымянных деревьев у нас не растет.'
  Dir['trees/**/*.tree'].sort.each do |file_name|
    puts file_name
    Tree.load_from_file_and_check(file_name)
    puts 'Желаете продолжить? [y/n]'
    answer = gets
    break if answer.chomp == 'n'
  end
else
  file_name = "trees/#{ENV['NAME']}" + '.tree'

  if File.exist?(file_name)
    Tree.load_from_file_and_check(file_name)
  else
    puts 'Данное дерево не растет в данном лесу.'
  end
end

puts 'Спасибо что были в нашем лесу'
