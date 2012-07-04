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

  gem.add_runtime_dependency('backports',  '~> 2.6.1')
  gem.add_runtime_dependency('mongo',      '~> 1.6.4')
  gem.add_runtime_dependency('veritas',    '~> 0.0.7')

  gem.add_development_dependency('rake',        '~> 0.9.2')
  gem.add_development_dependency('rspec',       '~> 1.3.2')
  gem.add_development_dependency('guard-rspec', '~> 0.7.0')
end
