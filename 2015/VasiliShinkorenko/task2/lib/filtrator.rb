require_relative 'searcher'

class Filtrator
  def initialize(version_and_sign)
    @version = validate_v(version_and_sign)
    @sign    = validate_s(version_and_sign)
  end

  def filter(versions)
    current_position = versions.index(@version)
    case @sign
    when '>'
      versions[0...current_position]
    when '<'
      versions[current_position + 1...versions.size]
    when '>='
      versions[0..current_position]
    when '<='
      versions[current_position...versions.size]
    when '~>'
      versions.select do |e|
        e[0] == @version[0] &&
        e[2] == @version[2] &&
        e[4] > @version[4]
      end
    end
    rescue ArgumentError => error
      print error, '. It seems there is no such version of this gem.' +
      'Check out all versions: \n'
  end

  def validate_v(param)
    param.match(/\s*(\d+\.)*\d+/).to_s.strip
  end

  def validate_s(param)
    param.match(/[!=><~]{1,2}/).to_s.strip
  end
end
