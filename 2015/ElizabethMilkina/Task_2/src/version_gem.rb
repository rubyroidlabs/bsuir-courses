require_relative 'name_gem'

class Version_gem

  def get_version

    begin
      filter = ARGV[1]
      $filtered_versions = []
      $not_matched_versions = []
      $gem_versions.each do |gem|
        if Gem::Dependency.new('', filter).match?('', gem.inner_html)
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

end
