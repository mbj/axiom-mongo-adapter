require 'spec_helper'

describe Axiom::Adapter::Mongo::Literal, '#integer' do
  subject { object.integer(value) }

  let(:object) { Axiom::Adapter::Mongo::Literal }

  context 'when value is a fixnum in int32 range' do
    let(:value) { 10 }

    it_should_behave_like 'an idempotent method'

    it 'should return value' do
      should equal(value)
    end
  end

  context 'when value is a float in int32 range' do
    let(:value) { 10.0 }

    it_should_behave_like 'an invalid int32'
  end

  context 'when value is a number not in int32 range' do
    let(:value) { 2**53 }

    it_should_behave_like 'an invalid int32'
  end
end
