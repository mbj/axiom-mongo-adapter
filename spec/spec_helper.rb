# encoding: utf-8

require 'veritas-mongo-adapter'
require 'devtools'
Devtools.init_spec_helper

include Veritas

# A relation used in many specs
BASE_RELATION = Relation::Base.new('name', [[:id,Integer],[:name,String]])

Spec::Runner.configure do |config|
  config.extend Spec::ExampleGroupMethods
end
