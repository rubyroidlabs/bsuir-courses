module GemVersionsFilter
  class GemVersion 
    VERSION_PATTERN = /(?<major>\d+)\.(?<minor>\d+)\.(?<tiny>\d+)(?:\.(?<postfix>\w+))?/

    attr_reader :full, :major, :minor, :tiny, :postfix, :hash_code

    def initialize(major, minor, tiny, postfix = nil)
      @major = major
      @minor = minor
      @tiny = tiny
      @postfix = postfix
      @hash_code = "#{major}#{minor}#{tiny}#{postfix}"
    end

    def to_s
      if postfix
        "#{major}.#{minor}.#{tiny}.#{postfix}"
      else
        "#{major}.#{minor}.#{tiny}"
      end
    end

    # region of overloaded operator
    def ==(version)
      @hash_code == version.hash_code
    end

    def >=(version)
      @hash_code >= version.hash_code
    end

    def <=(version)
      @hash_code <= version.hash_code
    end

    def >(version)
      @hash_code > version.hash_code
    end

    def <(version)
      @hash_code < version.hash_code
    end

    def self.parse(version)
      matched_Version = VERSION_PATTERN.match(version)

      major = matched_Version[:major].to_i
      minor = matched_Version[:minor].to_i
      tiny = matched_Version[:tiny].to_i
      postfix = matched_Version[:postfix]

      GemVersion.new(major, minor, tiny, postfix)
    end
  end
end
