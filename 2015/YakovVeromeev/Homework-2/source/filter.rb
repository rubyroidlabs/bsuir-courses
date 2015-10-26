class Filter
  def self.filter(versions, parametr)
    # conversion strings with vresion
    # to version number to ba able to compare them
    versions = versions.map { |version| Gem::Version.new(version) }
    operator, needed = parametr.split
    needed = Gem::Version.new(needed)
    filtered = []
    if operator == '~>'
      filtered = versions.select do |version|
      version >= needed && version < needed.bump
      # ex. ~> 1.2 means > 1.2 and <2.0
      end
    else
      filtered = versions.select do |version|
        version.send(operator.to_sym, needed)
        # the same as version >= needed if operator == '>='
      end
    end
    filtered.map(&:to_s)
    #at the end convert filtered versions to strings
  end
end

