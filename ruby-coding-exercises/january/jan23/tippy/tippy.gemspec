# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tippy/version'

Gem::Specification.new do |spec|
  spec.name          = 'tippy'
  spec.version       = Tippy::VERSION
  spec.authors       = ['Jordan Hudgens']
  spec.email         = ['jordan@wow.com']

  spec.summary       = 'A gem for generating tip values based on a number of inputs.'
  spec.homepage      = 'https://github.com/jordanhudgens/tippy'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
