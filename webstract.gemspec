# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'webstract/version'

Gem::Specification.new do |spec|
  spec.name          = "webstract"
  spec.version       = Webstract::VERSION
  spec.authors       = ["John Faucett"]
  spec.email         = ["jwaterfaucett@gmail.com"]
  spec.summary       = 'Extract information from websites'
  spec.description   = 'Extract images, favicons, and meta info from websites'
  spec.license       = 'MIT'

  spec.files         = Dir['lib/**/*.rb', 'spec/**/*.rb', 'README.md', 'LICENSE.txt']
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'mini_magick', '>= 3'
  spec.add_runtime_dependency 'activesupport', '>= 4.1', '< 5'
  spec.add_runtime_dependency 'poltergeist', '>= 1.5'
  spec.add_runtime_dependency 'faviconduit'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3'
  spec.add_development_dependency 'pry', '>= 0.10.0'

end
