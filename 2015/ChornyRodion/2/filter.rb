# Class for filtered data output
class Filter
  def initialize(list, filter_options)
    @list = list
    @filter_options = filter_options
    @filtered_versions = []
  end

  def filter(str)
    @filter_options.count.times do |i|
      unless Gem::Dependency.new('', @filter_options[i]).match?('', str)
        return false
      end
    end
    true
  end

  def filtered_versions
    @list.each { |str| @filtered_versions << str if filter(str) }
    @filtered_versions
  end
end
