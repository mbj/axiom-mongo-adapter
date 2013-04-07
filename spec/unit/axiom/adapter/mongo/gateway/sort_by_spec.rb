# encoding: utf-8
require 'spec_helper'

describe Adapter::Mongo::Gateway, '#sort_by' do
  let(:operation) { :sort_by }
  let(:factory)   { Relation::Operation::Order }
  let(:arguments) { [] }

  let(:block)     { lambda { |r| [r.id.asc] } }

  it_should_behave_like 'a supported unary relation method'
end
