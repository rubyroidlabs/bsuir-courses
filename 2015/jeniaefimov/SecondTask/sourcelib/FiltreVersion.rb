class FiltreVersion
  def initialize(versions, gversion)
    @versions = versions
    @gversion = gversion
  end

  def filter
    @versions.map { |v| v if Gem::Dependency.new('', @gversion).match?('', v) }
  end
end
