class ParseVersion
  def initialize
  end

  def filter(operator, needed_version, all_version)
    true_versions = []
    all_version.each do |version|
      case operator
      when '~>'
        if version < needed_version.bump && version >= needed_version
          true_versions << version
        end
      else
        if version.send(operator.to_sym, needed_version)
          true_versions << version
        end
      end
    end
    true_versions
  end
end
