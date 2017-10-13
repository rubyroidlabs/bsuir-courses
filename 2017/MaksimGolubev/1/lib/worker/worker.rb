require 'terminfo'
require 'colorize'
require 'yaml'
require 'json'

$LOAD_PATH.unshift(File.dirname(File.realpath(__FILE__)))

module Gardener
  class Worker
    SEPARATOR = '======='.red
    FILE_LIST = (Dir.entries("#{$LOAD_PATH[0]}/trees") - %w[. ..]).map do |tree|
      tree.sub('.tree', '')
    end.freeze

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
        puts 'Данное дерево не растет в данном лесу.'.yellow
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
      leaf = false

      if @tree_range < 4 * tree[0].count
        msg_for_valik = 'А в Питоне бы влезло...Шучу-шучу, оставьте на курсах)'
        msg_sep = if (@tree_range - msg_for_valik.size) / 2 > 0
                    '.' * ((@tree_range - msg_for_valik.size) / 2)
                  else
                    ''
                  end
        puts "#{msg_sep}#{msg_for_valik}#{msg_sep}".center(@tree_range).blue
      end

      tree.each do |node|
        next unless @tree_range > 4 * node.count
        leaf ? puts(('\ / ' * node.count).center(@tree_range)) : leaf = true
        puts node.join('  ').center(@tree_range).green
      end
      tree
    end

    def open_tree(tree_name)
      file_path = "#{$LOAD_PATH.first}/trees/#{tree_name}.tree"
      tree = File.open(file_path) { |file| JSON.parse(file.read) }
      tree
    end

    def find_name(params)
      return if params.empty?
      if params[0] =~ /NAME=(\w*)/
        params[0].match(/NAME=(\w*)/)[1]
      else
        raise 'Введите корректное имя дерева.'.red
      end
    end
  end
end
