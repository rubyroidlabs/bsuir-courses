# Class for handling input errors
class InputSecure
  def self.check?(stream)
    (stream.size - 1).times do |i|
      begin
        Gem::Dependency.new('', stream[i + 1]).match?('', '1.0.0')
      rescue ArgumentError
        puts "Invalid input => #{stream[i + 1]}"
        return false
      end
    end
    begin
      URI.parse("https://rubygems.org/gems/#{stream[0]}/versions").read
    rescue OpenURI::HTTPError
      puts 'Invalid game name ;( try again'
      return false
    end
    true
  end
end
