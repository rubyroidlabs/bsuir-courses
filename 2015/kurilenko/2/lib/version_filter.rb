class VersionFilter

  def initialize(condition)
    @operator = condition.match("[!=><~]{1,2}").to_s
    @version = condition[@operator.size..condition.size-1]
  end

  def filter(versions)
    if !versions.include?(@version)
      return nil
    end
    case @operator
      when "="
        [@version]
      when "!="
        versions - [@version]
      when ">"
        versions[0..get_version_position(@version, versions)-1]
      when "<"
        versions[get_version_position(@version, versions)+1..versions.size-1]
      when ">="
        versions[0..get_version_position(@version, versions)]
      when "<="
        versions[get_version_position(@version, versions)..versions.size-1]
      when "~>"
        versions[get_version_position(get_next_version, versions)..get_version_position(@version, versions)]
      else
        raise VersionOperatorError
    end
  end

  def get_version_position(version, mas)
    (0..mas.size-1).each do |i|
      if version == mas[i]
        return i
      end
    end
  end

  def get_next_version
    tmp_next_version = @version.split(".")
    tmp_next_version[-1] = "0"
    tmp_next_version[-2] = tmp_next_version[-2].to_i + 1
    tmp_next_version[-2] = tmp_next_version[-2].to_s
    next_version = tmp_next_version[0]
    (1..tmp_next_version.size-1).each do |i|
      next_version += "." + tmp_next_version[i]
    end
    next_version
  end

end
