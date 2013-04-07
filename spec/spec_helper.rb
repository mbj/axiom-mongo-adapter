# encoding: utf-8

require 'axiom-mongo-adapter'
require 'devtools'
Devtools.init_spec_helper

include Axiom

# A relation used in many specs
BASE_RELATION = Relation::Base.coerce('name', [[:id,Integer],[:name,String]])
