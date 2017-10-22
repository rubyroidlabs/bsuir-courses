require 'mechanize'

class Battle
  def initialize
    @agn = Mechanize.new
  end

  def parse(raper = '', criteria = '')
    @agn.get('https://genius.com/artists/King-of-the-dot')
    page = @agn.page.link_with(text: /Show all songs by King of the Dot/).click

    loop do
      links = []
      page.links.each do |link|
        links.push(link) if link.text.split(' ').include?('vs')
      end
      links.each do |link|
        txt = @agn.get(link.href).search('.song_body-lyrics').text.split("\n")
        name = txt[2].split(' Lyrics')
        name = name.first.split('        ')
        names = name.last
        name = name.last.split(' vs ')
        if name.include?(raper)
          out(scan(txt, name, criteria), names, link)
        elsif raper == ''
          out(scan(txt, name, criteria), names, link)
        end
      end

      page.links.each do |link|
        links = link if link.text.split(' ').include?('Next')
      end
      break if links.class.to_s != 'Mechanize::Page::Link'
      page = links.click
    end
  end

  private def out(battle, name, link)
    puts "#{name} - #{link.href}"
    battle.each do |key, value|
      puts "#{key} - #{value}" if key != ''
    end
    battle = battle.sort_by(&:last)
    puts battle.last.first + ' WINS!'
    puts
  end

  def scan(text, name, criteria)
    key = ''
    results = Hash.new(0)
    criteria == '' ? /\w/ : /#{criteria}/

    text.each do |line|
      if line.include?('[Round') && line.include?(name.first + ']')
        key = name.first
      elsif line.include?('[Round') && line.include?(name.last + ']')
        key = name.last
      else
        results[key] += line.scan(criteria).size
      end
    end
    results
  end
end
