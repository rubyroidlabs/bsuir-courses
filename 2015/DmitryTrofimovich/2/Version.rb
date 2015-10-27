require 'gems'

class Version
  attr_reader :gem_versions, :user_versions
  def initialize(name, params)
    @name = name
    @params = params
    @gem_versions = get_list_versions
    @user_versions = []
    get_versions
  end

  def get_list_versions
    g_ver = []
    if Gems.info(@name).class == String
      raise ArgumentError.new(Gems.info(@name))
    end
    Gems.versions(@name).each do |ver|
      g_ver << ver['number'].scan(/[0-9.]+/)
    end
    g_ver.flatten
  end

  def get_versions
    zn_param = []
    @params.each { |el| zn_param += el.split(' ') }
    zn_param.each_slice(2) do |zn, required_version|
      @user_versions << get_users_versions(zn, required_version)
    end
    @user_versions = @user_versions[1] & @user_versions[0] if @user_versions[1]
    @user_versions.flatten!
  end

  def get_users_versions(zn, required_version)
    usr_vers = []
    @gem_versions.each do |version|
      usr_vers << version if version.send(zn.to_sym, required_version)
    end
    usr_vers
  end
end
