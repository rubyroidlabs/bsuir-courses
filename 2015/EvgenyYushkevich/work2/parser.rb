require 'gems'
require 'colored'

class Parser
  def get_versions(gem_name)
    begin
      arr1 = Gems.versions(gem_name)
      # server gives this response if gem doesn't exist
      if arr1 == 'This rubygem could not be found.'
        # raise Exception.new('Invalid gem name.')
        puts 'Invalid gem name.'.blue
        exit
      end

    rescue SocketError
      raise Exception.new('Check your Internet connection.')
    end
    versions_array = Array.new
    arr1.each do |elem|
      versions_array = versions_array + [elem['number']]
    end
    versions_array
  end
end
