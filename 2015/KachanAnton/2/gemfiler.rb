Dir['./modules/*.rb'].each { |f| require(f) }

parser = Parser.new
parser.parse
versions = GemVersions.new(parser.req_gem).get_version
filter = FilterVersions.new(versions, parser.filter_version)
filtred_versions = filter.get_filtred_versions
OutputVersions.output_versions(filtred_versions)
