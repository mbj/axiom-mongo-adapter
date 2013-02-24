# -*- encoding: utf-8 -*-

require File.expand_path('../lib/veritas/adapter/mongo/version.rb', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = 'veritas-mongo-adapter'
  gem.version     = Veritas::Adapter::Mongo::VERSION.dup
  gem.authors     = [ 'Markus Schirp' ]
  gem.email       = [ 'mbj@seonic.net' ]
  gem.description = 'Mongodb adapter for veritas'
  gem.summary     = gem.description
  gem.homepage    = 'https://github.com/mbj/veritas-mongo-adapter'

  gem.require_paths    = [ 'lib' ]
  gem.files            = `git ls-files`.split("\n")
  gem.test_files       = `git ls-files -- spec`.split("\n")
  gem.extra_rdoc_files = %w[TODO]

  gem.add_dependency('mongo',         '~> 1.8.2')
  gem.add_dependency('veritas',       '~> 0.0.7')
  gem.add_dependency('adamantium',    '~> 0.0.6')
  gem.add_dependency('equalizer',     '~> 0.0.4')
  gem.add_dependency('abstract_type', '~> 0.0.4')
  gem.add_dependency('composition',   '~> 0.0.1')
  gem.add_dependency('null_logger',   '~> 0.0.1')
end
