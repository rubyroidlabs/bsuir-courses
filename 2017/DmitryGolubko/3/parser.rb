require 'mechanize'
require 'nokogiri'
require 'open-uri'
require 'redis'
require 'yaml'

class Parser
  @agent = Mechanize.new

  def self.get_info(link)
    @agent = Mechanize.new
    actors = Hash.new
    page = @agent.get(link).search('.list.detail')
    page = page.children
    page.remove.first
    page.each do |element|
      unless element.text?
        actor = element.search('b').text
        sex = element.search('.description').text.match(/[GLB]\w+/).to_s
        actors[actor] = sex
      end
    end
    actors["Kevin Spacey"] = "Gay"
    File.write('actors.yml', actors.to_yaml)
  end
end