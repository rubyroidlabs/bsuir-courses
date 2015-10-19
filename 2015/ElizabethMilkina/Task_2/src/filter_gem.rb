require_relative 'version_gem'
require 'colored'

class FilterGem
  def get_filter
    puts 'Версии, удовлетворяющие условию фильтрации:'
    if $filtered_versions.empty?
      puts 'Таких версий нет ;('.blue
    else
      for version in $filtered_versions
        puts version.green
      end
    end
    puts 'Версии, не удовлетворяющие условию фильтрации:'
    if $not_matched_versions.empty?
      puts 'Других версий нет :)'.yellow
    else
      for version in $not_matched_versions
        puts version.red
      end
    end
  end
end
