class Tree
  attr_accessor :maxDepth,:sumNodes,:arrayLevels
  def initialize
    @arrayLevels = []
  end

  def getLevel(arrayNodes)
    if self.arrayLevels.empty?
      arrayLevels << arrayNodes
    end
    level = []
    arrayNodes.each do |node|
      if node.nil?||(node.left.nil? && node.right.nil?)
        level << nil
        level << nil
      else
        level << node.left
        level << node.right
      end
    end
    level.each do |node|
      unless node.nil?
        self.arrayLevels << level
        getLevel(level)
        break
      end
    end
  end

  def show
    sumNodes = 0
    arrayIdent = []
    n=2
    (1..self.arrayLevels.size).each do |i|
      arrayIdent[self.arrayLevels.size-i] = n
      n=2*(n+1)
    end
    arrayIdent << 0
    i=0
    self.arrayLevels.each do|level|
      connectionLevel = ' '*((arrayIdent[i]+arrayIdent[i+1])/4)
      nodesLevel =  ' '*(arrayIdent[i]/2)
      level.each do |node|
        if node.nil?
          nodesLevel += sprintf('%2s',nil)
          connectionLevel+=' '*((arrayIdent[i+1]+2)/2+arrayIdent[i+1]*3/2+3)
        else
          sumNodes+=node.weight
          nodesLevel += sprintf('%2s',node.weight)
          if node.left.nil? && node.right.nil?
            connectionLevel+=' '*((arrayIdent[i+1]+2)/2+arrayIdent[i+1]*3/2+3)
          else
            connectionLevel+='/'+' '*((arrayIdent[i+1]+2)/2) + '\\' + ' '*(arrayIdent[i+1]*3/2+1)
          end
        end
        nodesLevel += ' '*arrayIdent[i]
      end
      puts nodesLevel
      puts connectionLevel
      i+=1
    end
    if sumNodes>5000
      puts 'Срубить'
    elsif self.arrayLevels.size>5
      puts 'Обрезать'
    else
      puts 'Оставить'
    end
  end
end
