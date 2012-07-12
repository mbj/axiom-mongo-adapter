# encoding: utf-8

require 'veritas-mongo-adapter'
require 'spec'
require 'spec/autorun'

include Veritas

# require spec support files and shared behavior
Dir[File.expand_path('../{support, shared}/**/*.rb', __FILE__)].each { |f| require f }

# A relation used in many specs
BASE_RELATION = Relation::Base.new('name', [[:id,Integer],[:name,String]])

Spec::Runner.configure do |config|
  config.extend Spec::ExampleGroupMethods
end
