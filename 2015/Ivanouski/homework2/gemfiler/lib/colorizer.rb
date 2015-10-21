class Colorizer < Array
	def initialize
		$ver_array = []
	end

	def push_colored(version)
		$ver_array.push version.red
	end

	def push_original(version)
		$ver_array.push version
	end
end
