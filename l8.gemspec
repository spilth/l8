# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'l8/version'

Gem::Specification.new do |spec|
  spec.name          = 'l8'
  spec.version       = L8::VERSION
  spec.authors       = ['Brian Kelly']
  spec.email         = ['polymonic@gmail.com']
  spec.summary       = %q{Gem for communicating with an L8 SmartLight}
  spec.homepage      = 'https://github.com/spilth/l8'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'rubyserial'
  spec.add_runtime_dependency 'digest-crc'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry'
end
