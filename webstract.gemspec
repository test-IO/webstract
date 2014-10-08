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

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'

  spec.add_runtime_dependency 'webshot'
  spec.add_runtime_dependency 'faviconduit'
end
