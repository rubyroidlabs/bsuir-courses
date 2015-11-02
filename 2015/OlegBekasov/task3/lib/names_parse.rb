require 'mechanize'
require 'colorize'
class NamesParse
  def initialize(group)
    @group = group
  end

  def names_parse
    agent = Mechanize.new
    page = agent.get("http://www.bsuir.by/schedule/schedule.xhtml?id=#{@group}")
    names = page.links_with(:href => %r{/schedule/})
    if names.nil?
      puts 'Check group number'.colorize(:red)
      exit
    end
    names.map! { |name| name.text }
    names.uniq.sort
  rescue SocketError
    puts 'Check your internet connection'.colorize(:red)
    exit
  end
end
