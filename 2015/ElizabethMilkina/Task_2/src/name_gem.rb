require 'open-uri'
require 'hpricot'

class NameGem
  def get_name(get_name)
    url = "https://rubygems.org/gems/#{get_name}/versions"
    @hp = Hpricot(open(url))
    if @hp
      puts 'Gem найден.'.bold.green
      version_list = []
      (@hp / 'a.t-list__item').each do |item|
        version_list.push(item.inner_html)
      end
      return version_list
    end
  rescue
    puts 'Gem не найден.'.bold.red
    exit
  end
end
