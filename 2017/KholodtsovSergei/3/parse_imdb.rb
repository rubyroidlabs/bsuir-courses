require 'open-uri'
require 'nokogiri'
require_relative 'celebrity'

class Parseimdb
  attr_accessor :html, :doc
  IMDB = 'http://www.imdb.com/list/ls072706884'.freeze

  def initialize
    @html = open(IMDB)
    @doc = Nokogiri::HTML(html)
  end

  def found_celebrity(people, orientation)
    celebrity = []
    people.each do |human|
      celebrity << Celebrity.new(human.text, orientation.shift, '')
    end
    celebrity
  end

  def found_orientation(all_description, orientation)
    all_description.each do |item|
      orientation << if item.text.include? 'Gay'
                       'Gay'
                     elsif item.text.include? 'Lesbian'
                       'Lesbian'
                     else
                       'Bisexual'
                     end
    end
    orientation
  end
end
