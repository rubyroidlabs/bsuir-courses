# Filters versions by requirements entered by user.
class Filter
  attr_reader :filtered_versions, :versions, :req

  def initialize(versions, req)
    @versions = versions
    @req = req
  end

  def filter_versions
    @filtered_versions = []
    begin
      @versions.each do |v|
        @filtered_versions << v if Gem::Dependency.new('', @req).match?('', v)
      end
    rescue Gem::Requirement::BadRequirementError
      raise StandartError 'Version format is invalid.'
    end
  end
end
