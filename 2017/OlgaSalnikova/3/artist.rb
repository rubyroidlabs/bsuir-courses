require 'csv'
require_relative 'sites/imdb'
require_relative 'sites/newnownext16'
require_relative 'sites/newnownext17'
require_relative 'sites/wikipedia'
require 'translit'

# Artist class is used for creating a artist as an object
class Artist
  DATABASE = 'database.csv'.freeze

  attr_reader :name, :translite_name

  def initialize(options = {})
    @name = options[:name]
    @description = options[:description]
    @translite_name = options[:translite_name]
  end

  def description
    @description.empty? ? 'Информация о каминг-аут не найдена.' : @description
  end

  class << self
    def find_by_name(name)
      CSV.foreach(DATABASE, headers: true, header_converters: :symbol, encoding: 'utf-8') do |row|
        if row[:name].include?(name) || row[:translite_name].include?(name)
          return new(row)
        end
      end
      nil
    end

    def artists_container
      return @artists_container if @artists_container
      artists_sources = [
        Newnownext2017.new.artists,
        Newnownext2016.new.artists,
        Imdb.new.artists,
        LgbtWikipedia.new.artists
      ]
      @artists_container = artists_sources.shift.dup
      artists_sources.each { |list| merge_artists(@artists_container, list) }
      @artists_container
    end

    def load_from_sites
      CSV.open(DATABASE, 'wb') do |csv|
        csv << %w[name description translite_name]
        artists_container.each do |name, description|
          csv << [name, description, translite(name)]
        end
      end
    end

    def translite(name)
      Translit.convert(name, :russian)
    end

    private

    def merge_artists(first_list, second_list)
      second_list.each do |name, description|
        if !first_list[name] || first_list[name].empty?
          first_list[name] = description
        end
      end
    end
  end
end
