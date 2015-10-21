class ParseVersion
  def initialize
  end

  def filter(operator, needed_version, all_version)
    true_versions = []
    case operator
    when '~>'
      all_version.each do |version|
        if version < needed_version.bump && version >= needed_version
          true_versions << version
        end
      end
    else
      all_version.each do |version|
        if version.send(operator.to_sym, needed_version)
          true_versions << version
        end
      end
    end
    true_versions
  end
end
