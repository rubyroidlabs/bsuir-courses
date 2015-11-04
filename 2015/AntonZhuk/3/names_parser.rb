require 'rubygems'
require 'mechanize'

class NamesParser
  def initialize(group_num)
    @num = group_num
  end

  def fetch_names
    agent = Mechanize.new
    @a=[]
    begin
    page = agent.get("http://www.bsuir.by/schedule/schedule.xhtml?id=#{@num}")
    rescue => e
      puts "Cannot connect to bsuir.by: #{e.message}"
    end
    page.search('div div table tr td a').each do |name|
      name = name.text
      if !@a.include?(name)
        @a.push(name)
      end
    end
    @a
  end
end
