require 'colored'

class GemsVersions
  def show_versions(gems_arr, first_cond, second_cond = '')
    gems_arr.each do |vers|
      if v_under_cond?(vers, first_cond) && v_under_cond?(vers, second_cond)
        puts vers.red
      else
        puts vers
      end
    end
  end

  def v_under_cond?(v, condition)
    Gem::Dependency.new('', condition).match?('', v.gsub(/[.][a-z]+[0-9]/, ''))
  end
end
