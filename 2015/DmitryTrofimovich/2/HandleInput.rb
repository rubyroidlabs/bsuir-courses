require 'thor'
require_relative('Version.rb')
require_relative('OutputVersions.rb')


class HandleInput < Thor
  desc "get NAME OPTIONS", "get versions gem"
  def get(name, param1, param2 = nil)
    @name, @params = name,[param1, param2].compact
    check_format_version
    vers_pool = Version.new(@name, @params)
    OutputVersions.new(vers_pool.gem_versions, vers_pool.user_versions)
  rescue ArgumentError => msg
    p msg
    return
  end

  no_commands do
    def check_format_version
      @params.each do |vers|
        unless /\A(>=|>|<|<=|~>) ([0-9]+\.)*[0-9]+\Z/ === vers.to_s
          raise ArgumentError.new('incorrect options')
        end
      end
    end
  end
end