require 'terminfo'
require 'colorize'
require 'yaml'

$LOAD_PATH.unshift(File.dirname(File.realpath(__FILE__)))

module Gardener
  class Worker
    SEPARATOR = '======='.red
    FILE_LIST = (Dir.entries("#{$LOAD_PATH.first}/trees") - %w[. ..]).map { |tree| tree.sub('.tree', '') }.freeze

    def initialize(params)
      @tree_name = find_name(params)
      @tree_range = TermInfo.screen_size[1]
    end

    def work
      if @tree_name.nil?
        FILE_LIST.each do |tree|
          puts "#{tree}.tree"
          tree = plant_tree(tree)
          work_with_tree_result(tree)
          print 'Желаете продолжить?[Y/n] '
          return nil if gets.chomp == 'n'
        end
      elsif FILE_LIST.include?(@tree_name)
        tree = plant_tree(@tree_name)
        work_with_tree_result(tree)
      else
        return puts 'Данное дерево не растет в данном лесу.'.yellow
      end
    end

    private

    def work_with_tree_result(tree)
      return puts 'Срубить.'.red if tree.flatten.sum > 5000
      return puts 'Обрезать.'.yellow if tree.count > 5
    end

    def plant_tree(tree_name)
      rec = Gardener::Recursion.new
      rec.recursion_tree(open_tree(tree_name))
      tree = rec.conv_arr.reverse

      if @tree_range < 4 * tree[0].count
        message_for_valik = "А в pyton-e бы влезло...Шучу-шучу, оставьте на курсах)"
        message_for_valik_separator = (@tree_range - message_for_valik.size) / 2 > 0 ? '.' * ((@tree_range - message_for_valik.size) / 2) : ''
        puts "#{message_for_valik_separator}#{message_for_valik}#{message_for_valik_separator}".center(@tree_range).blue
      end

      tree.each do |node|
        if @tree_range > 4 * node.count
          puts(('\ / ' * node.count).center(@tree_range).green)
          puts node.join('  ').center(@tree_range).green
        end
      end
      tree
    end

    def open_tree(tree_name)
      file_path = "#{$LOAD_PATH.first}/trees/#{tree_name}.tree"
      tree = File.open(file_path) { |file| file.read.chomp }
      eval tree
    end

    def find_name(params)
      # params.each { |arg| return arg.match(/NAME=(\w*)/)[1] if arg.match(/NAME=(\w*)/) }
      return nil if params.empty?
      if params[0] =~ /NAME=(\w*)/
        params[0].match(/NAME=(\w*)/)[1]
      else
        raise 'Введите корректное имя дерева.'.red
      end
    end
  end
end
