# Handle gem data
class Handler
  attr_accessor :gem_name, :option1, :option2

  def initialize(array, name, option1, option2 = nil)
    @cache_array = array
    @name = name
    @option1 = option1
    @option2 = option2
  end

  def print_cond_1
    @cache_array.each do |key|
      if fit?(@name, @option1, key)
        puts key.red
      else
        puts key
      end
    end
  end

  def print_cond_2
    @cache_array.each do |key|
      if fit?(@name, @option1, key) && fit?(@name, @option2, key)
        puts key.red
      else
        puts key
      end
    end
  end

  def fit?(name, option, key)
    Gem::Dependency.new(name.to_s, option).match?(name.to_s, key)
  end
end
