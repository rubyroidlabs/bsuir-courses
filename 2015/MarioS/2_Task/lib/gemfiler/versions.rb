require 'mechanize'
require 'colorize'

# parse rubygems.org
module Gemfiler
  class Versions
    URL_FORMAT = 'https://rubygems.org/gems/%s/versions'
    COMPARATORS = {
      '~>' => proc { |first, second| first == second },
      '>=' => proc { |first, second| first >= second },
      '<' => proc { |first, second| first < second }
    }

    def initialize(params)
      @conditions = params[:conditions]
      @gem_name = params[:gem_name]
      @conditions.map! do |condition|
        condition[:ver] = Gem::Version.new(condition[:ver])
        condition
      end
    end

    def to_s
      @versions ||= fetch_versions
      @versions.map do |ver|
        condition_fail = @conditions.all? do |condition|
          COMPARATORS[condition[:sign]].call(ver, condition[:ver])
        end
        if condition_fail
          "#{ver}".colorize(:red)
        else
          "#{ver}".colorize(:green)
        end
      end
    end

    def fetch_versions
      agent = Mechanize.new
      versions = []
      work_link = agent.get(format(URL_FORMAT, @gem_name))
      (work_link / '.t-list__item').each do |version|
        versions << Gem::Version.new(version.children.to_s)
      end
      versions
    rescue
      puts 'Gem not found or unable to connect to the internet.Try again.'
      exit
    end
  end
end
