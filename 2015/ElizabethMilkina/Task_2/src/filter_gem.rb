require_relative 'version_gem'
require 'colored'

class FilterGem
  def get_filter
    puts 'Версии, удовлетворяющие условию фильтрации:'
    if $filtered_versions.empty?
      puts 'Таких версий нет ;('.blue
    else
      (0..$filtered_versions.length).each do |i|
        puts $filtered_versions[i].to_s.green
      end
    end
    puts 'Версии, не удовлетворяющие условию фильтрации:'
    if $not_matched_versions.empty?
      puts 'Других версий нет :)'.yellow
    else
      (0..$not_matched_versions.length).each do |j|
        puts $not_matched_versions[j].to_s.red
      end
    end
  end
end
