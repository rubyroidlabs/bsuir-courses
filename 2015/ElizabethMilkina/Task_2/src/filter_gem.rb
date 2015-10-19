require_relative 'version_gem'
require 'colored'

class FilterGem
  def get_filter
    puts 'Версии, удовлетворяющие условию фильтрации:'
    $filtered_versions.empty? ? (puts 'Таких версий нет ;('.blue) :
        ($filtered_versions.each do |version|
          puts version.green
        end)
    puts 'Версии, не удовлетворяющие условию фильтрации:'
    $not_matched_versions.empty? ? (puts 'Других версий нет :)'.yellow) :
        ($not_matched_versions.each do |version|
          puts version.red
        end)
  end
end
