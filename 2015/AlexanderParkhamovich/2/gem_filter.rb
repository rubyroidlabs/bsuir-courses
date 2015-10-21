class Filter
  def self.get_filtered_versions(versions, req)
    filtered_versions = []
    begin
      versions.each do |v|
        filtered_versions << v if Gem::Dependency.new('', req).match?('', v)
      end
    rescue Gem::Requirement::BadRequirementError
      puts 'Invalid version format.'
      exit
    end
    filtered_versions
  end
end
