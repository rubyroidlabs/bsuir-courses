# Class for parsing html code into array of gem versions
class URLParse
  @slice_range = 0..32
  @filter_pattern = '/versions/'

  def self.find_versions(url)
    content = URI.parse(url).read

    array = content.split('>').select! { |str| str[@filter_pattern] }
    array.each { |str| str.slice!(@slice_range) }
    array.each { |str| str.slice!(str.length - 1) && str.sub!(url, '') }
    array.each { |str| str.sub!('/', '') }
  end
end
