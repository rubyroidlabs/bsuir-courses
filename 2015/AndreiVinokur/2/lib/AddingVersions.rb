require 'gems'

class AddingVersions
  def initialize(name)
    @name = name
  end

  def add
    gems_array = Gems.versions @name
    gems_array.map { |v| v['number'] }.uniq
  end
end
