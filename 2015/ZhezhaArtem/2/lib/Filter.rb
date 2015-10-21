class Filter
  def initialize(version, version1)
    @version = version
    @version1 = version1
    @versions_array = []
  end

  def get_version(versions_array)
    versions_array.each do |gem|
      @versions_array << gem["number"]
    end
  end

  def get_filtred_versions
    filter_versions = {}
    begin
      req = Gem::Requirement.new(@version, @version1)
      @versions_array.each do |vers|
        filter_versions[vers] = req.satisfied_by?(Gem::Version.new(vers))
      end
    rescue StandardError => exc
      puts 'Server could not sort'
      puts exc.message
      exit
    end
      filter_versions
  end
end
