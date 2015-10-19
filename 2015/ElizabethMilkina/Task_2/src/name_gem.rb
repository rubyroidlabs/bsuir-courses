require 'open-uri'
require 'hpricot'

class NameGem
  def get_name
      gem_name = ARGV[0]
      url = "https://rubygems.org/gems/#{gem_name}/versions"
      @hp = Hpricot(open(url))
      if @hp
        puts 'Gem найден.'.bold.green
        $gem_versions = (@hp / 'a.t-list__item')
      end
    rescue
      puts 'Gem не найден, повторите ввод.'.bold.red
      exit
  end
end
