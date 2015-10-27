require_relative 'version_gem'
require 'colored'

class OutputGem
  def output(filtered_versions, not_matched_versions)
    puts 'Версии, удовлетворяющие условию фильтрации:'
    if filtered_versions.empty?
      puts 'Таких версий нет ;('.blue
    else
      filtered_versions.each do |version|
        puts version.green
      end
    end
    puts 'Версии, не удовлетворяющие условию фильтрации:'
    if not_matched_versions.empty?
      puts 'Других версий нет :)'.yellow
    else
      not_matched_versions.each do |version|
        puts version.red
      end
    end
  end
end
