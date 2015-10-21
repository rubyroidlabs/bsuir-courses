Dir[File.expand_path('./../modules/*.rb', __FILE__)].each do
  |f| require(f)
end

class GemFiler
  def show_versions
    if ARGV.length < 2 || ARGV.length > 3
      puts 'Incorrect number of arguments.'
      exit
    end
    begin
      gem = ARGV[0]
      conditions = ARGV[1..ARGV.length - 1]
      versions = GemVersions.new(gem).get_version
      filter = FilterVersions.new(versions, conditions)
      filtred_versions = filter.get_filtred_versions
      OutputVersions.output_versions(filtred_versions)
    rescue StandardError => exc
      puts exc.message
      exit
    end
  end
end

GemFiler.new.show_versions
