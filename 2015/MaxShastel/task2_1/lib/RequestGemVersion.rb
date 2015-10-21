require 'json'

class RequestGemVersion
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def find
    begin
      result = `curl https://rubygems.org/api/v1/versions/#{name}.json`
      if result
        result = JSON.parse(result)
        result.map { |s| s['number'] }
      else
        raise RuntimeError.new('Not found')
      end
    rescue RuntimeError => e
      puts e.message
      exit
    end
  end
end