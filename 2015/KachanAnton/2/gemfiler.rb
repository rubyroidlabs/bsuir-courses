Dir[File.expand_path('./../modules/*.rb', __FILE__)].each {
  |f| require(f) }
class GemFiler
  def self.show_versions
    begin
    if ARGV.length < 2 || ARGV.length > 3
      raise ArgumentError, 'Ibcorrect number of arguments.'
      exit
    end
    gem = ARGV[0]
    conditions = ARGV[1..ARGV.length - 1]
    versions = GemVersions.new(gem).get_version
    filtred_versions = FilterVersions.new(versions, conditions).get_filtred_versions
    OutputVersions.output_versions(filtred_versions)
    rescue StandardError => exc
      puts exc.message
      exit
    end
  end
end

GemFiler.show_versions
