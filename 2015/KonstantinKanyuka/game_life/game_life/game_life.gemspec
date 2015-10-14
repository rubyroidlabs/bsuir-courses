Gem::Specification.new do |s|
  s.name = 'game_life'
  s.version = '1.0.1'

  s.authors = ['Konstatntin Kanyuka']
  s.email = 'kkan.web@gmail.com'

  s.date = Time.now.strftime("%Y-%m-%d")

  s.homepage = 'http://github.com/kkan'
  s.description = 'Implements logic of Conway\'s Game of Life'
  s.summary = 'Conway\'s Game of Life'
  s.license = 'MIT'

  s.files = Dir['lib/**/*.rb']
end