# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name        = 'axiom-mongo-adapter'
  gem.version     = '0.0.1'
  gem.authors     = [ 'Markus Schirp' ]
  gem.email       = [ 'mbj@seonic.net' ]
  gem.description = 'Mongodb adapter for axiom'
  gem.summary     = gem.description
  gem.homepage    = 'https://github.com/mbj/axiom-mongo-adapter'

  gem.require_paths    = [ 'lib' ]
  gem.files            = `git ls-files`.split("\n")
  gem.test_files       = `git ls-files -- spec`.split("\n")
  gem.extra_rdoc_files = %w[TODO]

  gem.add_dependency('mongo',         '~> 1.8.4')
  gem.add_dependency('axiom',         '~> 0.1.0')
  gem.add_dependency('adamantium',    '~> 0.0.7')
  gem.add_dependency('equalizer',     '~> 0.0.5')
  gem.add_dependency('abstract_type', '~> 0.0.5')
  gem.add_dependency('concord',       '~> 0.0.3')
  gem.add_dependency('null_logger',   '~> 0.0.1')
end
