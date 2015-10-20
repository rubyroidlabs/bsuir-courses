require 'colored'

class GemsVersions
  def show_versions(gems_arr, first_condition, second_condition = '')
    gems_arr.each do |vers|
      if is_version_under_condition(vers, first_condition) && 
        is_version_under_condition(vers, second_condition)
        puts vers.red
      else
        puts vers
      end
    end
  end

  def is_version_under_condition(v, condition)
    Gem::Dependency.new('', condition).match?('', v.gsub(/[.][a-z]+[0-9]/, ''))
  end
end
