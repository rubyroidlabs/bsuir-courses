require 'open-uri'
require 'hpricot'

class NameGem
  def get_name(get_name)
    url = "https://rubygems.org/gems/#{get_name}/versions"
    @hp = Hpricot(open(url))
    if @hp
      puts 'Gem найден.'.bold.green
      return (@hp / 'a.t-list__item')
    end
  rescue
    puts 'Gem не найден.'.bold.red
    exit
  end
end
