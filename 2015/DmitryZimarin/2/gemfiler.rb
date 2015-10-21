require 'rubygems'
require 'gems'
require 'colorize'

class Comparer
  def compare?(given_version, array_version, relation)
    @given_version = Gem::Version.new(given_version)
    @array_version = Gem::Version.new(array_version)
    case relation
    when '>'
      bigger?
    when '<'
      smaller?
    when '=>'
      (equal? || bigger?)
    when '<='
      (equal? || smaller?)
    when '~>'
      spermie?
    when '='
      equal?
    when '!='
      !equal?
    else false
    end
  end

  def bigger?
    @array_version > @given_version
  end

  def smaller?
    @array_version < @given_version
  end

  def equal?
    @array_version.eql?(@given_version)
  end

  def spermie?
    @given_version <= @array_version && @array_version < @given_version.bump
  end
end

class GemData
  def initialize
    @gem_name = ARGV[0]
    @params_versions = []
    inin_version_mas!
    @gems_versions_mas = Gems.versions @gem_name
  end

  def inin_version_mas!
    ARGV[1..-1].each do |str|
      @params_versions.push [str.split[1], str.split[0]]
    end
  end
  attr_accessor :gem_name, :params_versions, :gems_versions_mas
end

class Printer
  def print(temp_gem_data)
    temp_gem_data.gems_versions_mas.each do |array_version_data|
      cur_ver_num = array_version_data['number']
      p include_current_version?(temp_gem_data, cur_ver_num) ? cur_ver_num.red : cur_ver_num
    end
  end

  def include_current_version?(temp_gem_data, current_version)
    comparer = Comparer.new
    result = true
    temp_gem_data.params_versions.each do |param_ver, param_relation|
      result &&= comparer.compare?(param_ver, current_version, param_relation)
    end
    result
  end
end

def main
  if ARGV.length < 2
    p 'Wrong number of arguments'
  else
    temp_gem_data = GemData.new
    printer = Printer.new
    printer.print(temp_gem_data)
  end
end

main
