require 'open-uri'
require 'nokogiri'
require_relative 'celebrity'

class Parsenewnownext
  attr_reader :doc, :html

  def initialize(link)
    @html = open(link)
    @doc = Nokogiri::HTML(html)
  end

  def found_celebrity(people, all_description, celebrity)
    celebrity.each do |item|
      next unless people.include?(item.celebrity['name'])
      i = people.index(item.celebrity['name'])
      item.celebrity['info'] += all_description[i]
      people.delete(people[i])
      all_description.delete(all_description[i])
    end
    people.each do |human|
      celebrity << Celebrity.new(human, '', all_description.shift)
    end
    celebrity
  end
end
