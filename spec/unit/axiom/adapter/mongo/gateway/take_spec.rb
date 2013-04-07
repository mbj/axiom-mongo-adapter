# encoding: utf-8
require 'spec_helper'

describe Adapter::Mongo::Gateway, '#take' do
  let(:operation) { :take }
  let(:factory)   { Relation::Operation::Limit }
  let(:arguments)  { [5] }

  it_should_behave_like 'a supported unary relation method'
end
