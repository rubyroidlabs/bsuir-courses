class FilterVersions
  def initialize(versions_array, conditions)
    @versions_array = versions_array
    @conditions = conditions
  end

  def get_filtred_versions
    filter_versions = {}
    begin
      requier = Gem::Requirement.new(@conditions)
      @versions_array.each do |vers|
        filter_versions[vers] = requier.satisfied_by?(Gem::Version.new(vers))
      end
      puts filter_versions
    rescue StandardError => exc
      puts 'Server could not sort'
      puts exc.message
      exit
    end
    filter_versions
  end
end
