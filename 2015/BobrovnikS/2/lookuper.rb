# Look up gem data
require 'gems'

class LookUper
  attr :cache_array, :gem_name, :option1, :option2

  def initialize(gem_name, option1, option2 = nil)
    @cache_array ||= Array.new
    @gem_name = gem_name
    @option1 = option1
    @option2 = option2
  end

  def lookup
    hash = Gems.versions(@gem_name)
    hash.each do |k, _v|
      k.each do |key, value|
        @cache_array.push(value) if key == 'number'
      end
    end
    rescue StandardError
      puts "The gem name you entered doesn't exist"
  end
end
