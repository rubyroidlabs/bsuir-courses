# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'life/version'

Gem::Specification.new do |spec|
  spec.name          = "swarmer_life"
  spec.version       = Life::VERSION
  spec.authors       = ["Anton Barkovsky"]
  spec.email         = ["anton@swarmer.me"]

  spec.summary       = %q{Task 3}
  spec.homepage      = "https://github.com/rubyroidlabs/bsuir-courses"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency "curses", "~> 1.0"
end
