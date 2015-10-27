require 'colored'

class Visualiser
  def initialize(versions)
    @versions = versions
  end

  def visualise(filter)
    @versions.each { |v| puts (filter.include?(v) ? v.red : v) }
  end
end
