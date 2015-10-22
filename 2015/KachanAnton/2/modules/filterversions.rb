class FilterVersions
  def initialize(versions_array, conditions)
    @versions_array = versions_array
    @conditions = conditions
  end

  def get_filtred_versions
    filter_versions = {}
    begin
      requier = Gem::Requirement.new(@conditions)
      @versions_array.select {
        |v| filter_versions[v] = requier.satisfied_by?(Gem::Version.new(v))}
    rescue StandardError => exc
      puts 'Server do not call'
      puts exc.message
      exit
    end
    filter_versions
  end
end
