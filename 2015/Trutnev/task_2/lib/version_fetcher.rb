require 'json'
class VersionFetcher

	def initialize(name)
		@name=name
	end

def fetch
     #binding.pry
     result = `curl https://rubygems.org/api/v1/versions/#{@name}.json`
     json = JSON.parse(result)
     json.map{|x | x['number']}
end

end