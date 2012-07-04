# encoding: utf-8
require 'spec_helper'

describe Adapter::Mongo::Gateway, '#restrict' do
  let(:operation) { :restrict }
  let(:factory)   { Algebra::Restriction }
  let(:arguments) { [] }

  let(:block)     { lambda { |r| r.id.eq(1) } }

  it_should_behave_like 'a supported unary relation method'
end
