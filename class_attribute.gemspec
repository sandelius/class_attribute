require_relative './lib/class_attribute/version'

Gem::Specification.new do |spec|
  spec.name          = 'class_attribute'
  spec.version       = ClassAttribute::VERSION
  spec.authors       = ['Tobias Sandelius']
  spec.email         = ['tobias@sandeli.us']
  spec.summary       = %q{Inheritable class level variable accessors}
  spec.homepage      = 'https://github.com/sandelius/class_attribute'
  spec.license       = 'MIT'
  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler',   '~> 1.6'
  spec.add_development_dependency 'rake',      '~> 10'
  spec.add_development_dependency 'minitest',  '~> 5'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'coveralls'
end
