require_relative('parse.rb')

class Filter
  def initialize(data)
    @versions = data.map do |ver|
      @a = Gem::Version.new(ver)
    end
  end

  def filter_data(param,
                  version,
                  param2,
                  version2)
    specified =  Gem::Version.new(version)
    specified2 = Gem::Version.new(version2)

    if !@versions.include?(specified)
      puts 'Incorrect version!'
      exit
    end

    filtered_versions = []
    case
    when param == '>=' && param2 == nil
      filtered_versions = @versions.select do |ver|
        ver >= specified
      end
    when param == '<' && param2 == nil
      filtered_versions = @versions.select do |ver|
        ver < specified
      end
    when param == '~>' && param2 == nil
      filtered_versions = @versions.select do |ver|
        ver >= specified && ver < specified.bump
      end
    when param == '>=' && param2 == '<'
      filtered_versions = @versions.select do |ver|
        ver >= specified && ver < specified2
      end
    else
      puts 'Incorrect parameters'
      exit
    end
    filtered_versions.map { |ver| ver.to_s }
  end
end
