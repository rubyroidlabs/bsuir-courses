class Version
  def initialize(versions, requirements)
    @versions = versions
    @reqs = requirements
  end

  def find
    @find_versions = []

    @versions.each do |v|
      if (@reqs[0].satisfied_by? v) && (@reqs[1].satisfied_by? v)
        @find_versions.push(@versions.index(v))
      end
    end
  end
end
