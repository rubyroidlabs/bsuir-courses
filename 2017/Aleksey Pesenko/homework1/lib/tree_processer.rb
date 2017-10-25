require 'json'
require 'pry'

class TreeProcesser
  def self.print_tree(tree)
    depth = tree_depth tree
    1.upto(depth) do |i|
      @spaces = depth - i + 1
      print '  ' * (2**@spaces / 2)
      print_level(tree, i)
      if i != depth
        print "\n" + '  ' * ((2**(@spaces - 1)) / 2)
        (2**(i - 1)).times do
          print ' /' + '  ' * ((2**(@spaces - 1)) - 1)
          print '\\ ' + '  ' * ((2**(@spaces - 1)) - 1)
        end
      end
      puts
    end
    puts
  end

  def self.tree_depth(brunch)
    left = value_for_counting_depth(brunch[1][0])
    right = value_for_counting_depth(brunch[1][1])
    (left >= right ? left : right) + 1
  end

  def self.tree_age(brunch)
    left = value_for_counting_age(brunch[1][0])
    right = value_for_counting_age(brunch[1][1])
    brunch[0] + left + right
  end

  private_class_method def self.value_for_counting_age(val)
    val.is_a?(Integer) ? val : tree_age(val)
  end

  private_class_method def self.value_for_counting_depth(val)
    val.is_a?(Integer) ? val : tree_depth(val)
  end

  private_class_method def self.print_level(brunch, level)
    level -= 1
    if level.zero?
      helper_method(brunch)
    else
      print_level(brunch[1][0], level)
      print_level(brunch[1][1], level)
    end
  end

  private_class_method def self.helper_method(brunch)
    p = brunch.class == Array ? brunch[0] : brunch
    print format('%-2d', p)
    print '  ' * (2**@spaces - 1)
  end
end
