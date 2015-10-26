require_relative 'name_gem'

class VersionGem
  def get_version(gem_versions, command)
    filtered_versions = []
    not_matched_versions = []
    gem_versions.each do |gem|
      if Gem::Dependency.new('', command[0]).match?('', gem.inner_html)
        if command.length == 2
          if Gem::Dependency.new('', command[1]).match?('', gem.inner_html)
            filtered_versions.push(gem.inner_html)
          else
            not_matched_versions.push(gem.inner_html)
          end
        else
          filtered_versions.push(gem.inner_html)
        end
      else
        not_matched_versions.push(gem.inner_html)
      end
    end
    return filtered_versions, not_matched_versions
  rescue
    puts 'Проверьте правильность ввода операции.'.bold.red
    exit
  end
end
