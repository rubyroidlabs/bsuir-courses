require 'gems'
require 'optparse'
require 'json'
require 'colored'
class VersionGetter
  def initialize(name)
    @name = name
  end

  def get
    getgem = `curl https://rubygems.org/api/v1/versions/#{@name}.json`
    if getgem == nil
      raise NameError
    end
    json = JSON.parse(getgem)
    json.map do |s|
      s['number']
    end
  end
end
class Comparator
  def initialize(checkingcondition)
    @sign = checkingcondition.match('[!=><~]{1,2}').to_s
    @version =
checkingcondition[@sign.size..checkingcondition.size - 1]
  end

  def compare(versions)
    if !versions.include?(@version)
      return nil
    end
    case @sign
    when '='
      [@version]
    when '!='
      versions - [@version]
    when '>'
      versions[0..get_version_position(@version, versions) - 1]
    when '<'
      versions[get_version_position(@version, versions) + 1..versions.size - 1]
    when '>='
      versions[0..get_version_position(@version, versions)]
    when '<='
      versions[get_version_position(@version, versions)..versions.size - 1]
    when '~>'
      versions[[get_version_position(get_next_version,
      versions)..get_version_position(@version, versions)]
      ]	
    else
      raise VersionOperatorError
    end
  end

  def get_version_position(version, mas)
    (0..mas.size - 1).each do |i|
      if version == mas[i]
        return i
      end
    end
  end

  def get_next_version
    tmp_next_version = @version.split('.')
    tmp_next_version[-1] = '0'
    tmp_next_version[-2] = tmp_next_version[-2].to_i + 1
    tmp_next_version[-2] = tmp_next_version[-2].to_s
    next_version = tmp_next_version[0]
    (1..tmp_next_version.size - 1).each do |i|
      next_version += '.' + tmp_next_version[i]
    end
    next_version
  end
end

class PrintToConsole
  def initialize(filtered_versions, versions)
    @filtered_versions = filtered_versions
    @versions = versions
  end

  def print
    if !@filtered_versions.nil?
      i = 0
      @versions.map do |s|
        if s == @filtered_versions[i]
          puts s.red
          i += 1
        else
          puts s
        end
      end
    end
  end
end
OptionParser.new do |opts|
  opts.banner = "Usage: ./2 [gem] [vers1] [vers2]
  Example: ./2 thor '>= 0.10' '<0.14'"
end.parse!
begin
  gem, vers = ARGV
  versions = VersionGetter.new(gem).get
  puts 123
  filtered_versions = Comparator.new(vers).compare(versions)
  PrintToConsole.new(filtered_versions, versions).print
rescue ArgumentError
  begin
    puts 'write [gem] then [version] then [another version]'
    puts 'without brackets!!! sqa :) '
  end
end
