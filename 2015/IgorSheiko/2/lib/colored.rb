require 'colorize'

class ColoredOutput
	def initialize(all_version, true_version)
		@all_version = all_version.map { |version| version.to_s}
		@true_version = true_version.map { |version| version.to_s}
	end

	def colored_output
		@all_version.each do |version|
			if @true_version.include?(version)
				puts version.red 
			else
				puts version
			end
		end
	end
end
