class Tree
  attr_accessor :left
  attr_accessor :right
  attr_accessor :value
  def initialize(value=nil)
    @value=value
    @left=nil
    @right=nil
    @sum=0
    @depth=0
  end
  def value; @value; end
  def right; @right;end
  def left; @left;end
  def sum;@sum;end
  def depth;@depth;end
  def print_leveled_tree(tree,level,side)
    if tree==nil
      return
    end
    print_leveled_tree(tree.right,level+1,0)
    i=0
    str=""
    while i<level
      str+= "    "
      i+=1
    end
    if side==0
      str+=" /---"
    elsif side ==2 
      str+=" "
    else
      str+=" \\---"
    end
    puts "#{str}#{tree.value} \n"
    print_leveled_tree(tree.left,level+1,1)
  end
  def get_tree_sum(tree)
    if tree==nil 
      return
    end
    get_tree_sum(tree.left)
    @sum+=tree.value
    get_tree_sum(tree.right)
  end 
  def rec_arr(tree,tree_arr)
    if tree==nil
      tree=Tree.new()
    end
    if !tree_arr[0].is_a?(Array) && tree_arr[1].is_a?(Array)
      tree.value=tree_arr[0]
      tree.left=rec_arr(tree.left,tree_arr[1][0])
      if tree.left==nil
        tree.left=Tree.new()
        tree.right=Tree.new()
        tree.left.value=tree_arr[1][0]
        tree.right.value=tree_arr[1][1]
      end
      tree.right=rec_arr(tree.right,tree_arr[1][1])
      if tree.right==nil
        tree.left=Tree.new()
        tree.right=Tree.new()
        tree.left.value=tree_arr[1][0]
        tree.right.value=tree_arr[1][1]
      end
    end
    if !tree_arr[0].is_a?(Array) && !tree_arr[1].is_a?(Array)
      return nil
    end
    return tree
  end
  def get_max_depth(tree,depth)
    if tree == nil
      return depth
    end
      @depth=[get_max_depth(tree.left,depth+1),get_max_depth(tree.right,depth+1)].max
  end
end

