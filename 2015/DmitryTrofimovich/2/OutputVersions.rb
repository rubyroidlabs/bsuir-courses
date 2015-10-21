require 'colored'
require_relative('Version.rb')

class OutputVersions
  def initialize
    @ver = Version.new
    self.OutputToTerminal
  end

  def OutputToTerminal
    @ver.vers.each do |v|
      if @ver.vers_usr.include?(v['number']) 
        p v['number'].red
      else 
        p v['number']
      end
    end
  end
end
