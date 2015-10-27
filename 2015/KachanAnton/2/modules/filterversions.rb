class FilterVersions
  def initialize(versions_array, conditions)
    @ver_arr = versions_array
    @conditions = conditions
  end

  def get_filtred_versions
    filt_v = {}
    begin
      r = Gem::Requirement.new(@conditions)
      @ver_arr.select { |v| filt_v[v] = r.satisfied_by?(Gem::Version.new(v)) }
    rescue StandardError => exc
      puts 'Server do not call'
      puts exc.message
      exit
    end
    filt_v
  end
end
