require 'spec_helper'

describe Veritas::Adapter::Mongo::Literal,'#positive_integer' do
  subject { object.positive_integer(value) }

  let(:object) { Veritas::Adapter::Mongo::Literal }

  context 'when value is a positive fixnum in int32 range' do
    let(:value) { 10 }

    it_should_behave_like 'an idempotent method'

    it 'should return value' do
      should equal(value) 
    end
  end

  context 'when value is a zero fixnum in int32 range' do
    let(:value) { 0 }

    it_should_behave_like 'an idempotent method'

    it 'should return value' do
      should equal(value) 
    end
  end

  context 'when value is a negative fixnum in int32 range' do
    let(:value) { -10 }

    it 'should raise error' do
      expect { subject }.to raise_error(ArgumentError,'Not a positive value: -10')
    end
  end

  context 'when value is not an integer in int32 range' do
    let(:value) { 2**33 }

    it_should_behave_like 'an invalid int32'
  end
end
