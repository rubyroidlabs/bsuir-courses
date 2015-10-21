Dir[File.expand_path('./../modules/*.rb', __FILE__)].each do
  |f| require(f)
end

class GemFiler
  def self.show_versions
    begin
      if ARGV.length < 2 || ARGV.length > 3
        puts 'Incorrect number of arguments.'
        exit
      end
      versions = GemVersions.new(ARGV[0]).get_version
      filter = FilterVersions.new(versions, ARGV[1..-1])
      filtred_versions = filter.get_filtred_versions
      OutputVersions.output_versions(filtred_versions)
    rescue StandardError => exc
      puts exc.message
      exit
    end
end
end

GemFiler.show_versions
