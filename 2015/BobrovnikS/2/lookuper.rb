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
    begin
      hash = Gems.versions(@gem_name)
      hash.each do |k, v|
        k.each do |k, v|
          cache_array.push(v) if k == 'number'
        end
      end
    rescue
      puts "The gem name you entered doesn't exist"
    end
  end
end
