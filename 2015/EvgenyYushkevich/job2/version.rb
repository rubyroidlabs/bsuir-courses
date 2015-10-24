require 'colored'

class Version
  def initialize(vers, colored)
    @version = vers
    @has_color = colored
  end

  def print_version
    if @has_color
      puts @version.red
    else
      puts @version
    end
  end
end
