class Version
  def initialize(versions, requirements)
   @versions = versions
   @requirements = requirements
  end

  def find
    @find_versions = []

    @versions.each do |v|
      if (@requirements[0].satisfied_by? v) && (@requirements[1].satisfied_by? v)
        @find_versions.push(@versions.index(v))
      end
    end
  end
end
