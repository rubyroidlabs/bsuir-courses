require_relative 'name_gem'

class VersionGem
  def get_version
    $filtered_versions = []
    $not_matched_versions = []
    $gem_versions.each do |gem|
      if Gem::Dependency.new('', ARGV[1]).match?('', gem.inner_html)
        $filtered_versions.push(gem.inner_html)
      else
        $not_matched_versions.push(gem.inner_html)
      end
    end
  rescue
    puts 'Проверьте правильность ввода операции и повторите.'.bold.red
    exit
  end
end
