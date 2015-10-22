require 'gems'
require 'colored'

class RubyGemsParser
  def get_gem_versions(gem_name)
    gems_array = Gems.versions gem_name
    if gems_array.empty?
      fail 'Not existing gem.'
    end
    gems_array.map { |v| v['number'] }.uniq
  rescue StandardError => e
    puts e.message.red
  end
end
