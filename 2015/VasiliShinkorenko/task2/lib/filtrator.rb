require_relative 'searcher'

class Filtrator
  def initialize(v_and_sign)
    @version = validate(v_and_sign, /\s*(\d+\.)*\d+/)
    @sign    = validate(v_and_sign, /[!=><~]{1,2}/)
  end

  def filter(versions)
    current_position = versions.index(@version)
    begin
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
      print error, ". It seems there is no such version of this gem." +
      "Check out all versions: \n"
    end
  end

  def validate(param, regex)
    param.match(regex).to_s.strip
  end
end
