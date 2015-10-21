Dir['./lib/*.rb'].each { |f| require_relative(f) }

begin
  if (ARGV.length < 2)
    #raise RuntimeError.new('No arguments')
  else
    name = ARGV[0]
    ver = ARGV[1]
    versions_arr = RequestGemVersion.new(name).find
    if versions
      filter = GemVersion.new(versions_arr, ver.dup).filter
      if filter
        OutVersion.new(versions_arr, filter).write
      end
    end
  end
rescue RuntimeError => e
  puts e.message
  exit
end

