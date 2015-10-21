require 'colored'
require_relative('Version.rb')

class OutputVersions
  def initialize
    @ver = Version.new
    self.output_to_terminal
  end

  def output_to_terminal
    @ver.vers.each do |v|
      if @ver.vers_usr.include?(v['number'])
        p v['number'].red
      else
        p v['number']
      end
    end
  end
end
