class Filter

  def self.filter(versions, parametr)
    versions = versions.map { |version| Gem::Version.new(version) }
    operator, needed = parametr.split
    needed = Gem::Version.new(needed)
    filtered = []
    if operator == '~>'
      filtered = versions.select do |version|
        version >= needed && version < needed.bump
    end
    else
      filtered = versions.select do |version|
        version.send(operator.to_sym, needed)
      end
    end
    filtered.map { |version| version.to_s }
  end
  
end
