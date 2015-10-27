require 'rubygems'
require 'colorize'

class GemAnalysis
  def initialize(versions_list, dependencies)
    @versions_list = versions_list
    @quantity_of_params = dependencies.size
    if @quantity_of_params == 2
      @low_ver = Gem::Version.new(dependencies['>='])
      @hight_ver = Gem::Version.new(dependencies['<'])
    else
      dependencies.each_pair { |param, vers| @param_ver = param + vers }
    end
  end

  def out
    @versions_list.each do |ver|
      case @quantity_of_params
      when 1
        if Gem::Dependency.new('', @param_ver).match?('', ver)
          puts ver.red
        else
          puts ver
        end
      when 2
        @vers = Gem::Version.new(ver)
        if (@vers < @hight_ver) && (@vers >= @low_ver)
          puts ver.red
        else
          puts ver
        end
      end
    end
  end
end
