require_relative 'searcher'

class Filtrator
  def initialize(version_and_sign)
    @version = version_and_sign.match(/\s*(\d+\.)*\d+/).to_s.strip
    @sign    = version_and_sign.match(/[!=><~]{1,2}/).to_s.strip
  end

  def filter(versions)
    current_position = versions.index(@version)
    second_part = versions[2]
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
        # TODO: save elements after filtering
        versions.select { |e| e[0] == @version[0] && 
                              e[2] == @version[2] && 
                              e[4] > @version[4] }
      end
    rescue ArgumentError => error
      print error, ". It seems there is no such version of this gem. 
                      Check out all versions: \n"
    end
  end
end
