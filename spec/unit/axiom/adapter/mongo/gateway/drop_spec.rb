# encoding: utf-8

require 'spec_helper'

describe Adapter::Mongo::Gateway, '#drop' do
  let(:operation) { :drop }
  let(:factory)   { Relation::Operation::Offset }
  let(:arguments) { [5] }

  it_should_behave_like 'a supported unary relation method'
end
