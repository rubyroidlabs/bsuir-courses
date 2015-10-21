# Filter
class GemFilter
  def initialize(versions, input_version)
    @versions = versions.map { |version| Gem::Version.new(version) }
    @input_version = input_version
    @filter_versions = []
  end

  def filter
    param1 = @input_version[0]
    v1 = Gem::Version.new(@input_version[1])
    param2 = @input_version[2]
    v2 = Gem::Version.new(@input_version[3]) if !@input_version[3].nil?
    if param2 == nil
      case
      when param1 == '>='
        @filter_versions = @versions.select { |ver| ver >= v1 }
      when param1 == '<'
        @filter_versions = @versions.select { |ver| ver < v1 }
      when param1 == '~>'
        @filter_versions = @versions.select { |ver| ver >= v1 && ver < v1.bump }
      when param1 == nil
        @filter_versions = @versions.select { |ver| ver == v1 }
      end
    else
      if param1 == '>='
        @filter_versions = @versions.select { |ver| ver >= v1 && ver < v2 }
      end
    end
    @filter_versions.map!(&:version)
  end
end
