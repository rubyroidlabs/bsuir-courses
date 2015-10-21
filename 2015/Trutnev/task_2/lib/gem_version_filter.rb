class VersionFilter

		def initialize(versions,condition)
			@versions=versions
			@condition=condition
		end

	def filter
	     #ALGORITM
	     versions.each do |versions|
        filtered_versions << versions if Gem::Dependency.new('', condition).match?('', versions)

	     @versions
@filtered_versions
	end
end