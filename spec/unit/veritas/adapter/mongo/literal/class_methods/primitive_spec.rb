require 'spec_helper'

describe Adapter::Mongo::Literal,'#primitive' do
  subject { object.primitive(primitive) }

  let(:object)    { Adapter::Mongo::Literal }

  context 'when primitive is a String' do
    let(:primitive) { 'foo' }
    it { should be(primitive) }

    it_should_behave_like 'an idempotent method'
  end

  context 'when primitive is an Float' do
    let(:primitive) { 1.0 }
    it { should be(primitive) }

    it_should_behave_like 'an idempotent method'
  end

  context 'when primitive is an Integer' do
    let(:primitive) { 1 }
    it { should be(primitive) }

    it_should_behave_like 'an idempotent method'
  end

  context 'when primitive is an Array with valid primitives' do
    let(:primitive) { 'foo' }
    it { should be(primitive) }

    it_should_behave_like 'an idempotent method'
  end

  context 'when primitive is an Array with invalid primitives' do
    let(:invalid_element) { Object.new }
    let(:primitive) { [invalid_element] }

    it 'should raise error' do
      expect { subject }.to raise_error(ArgumentError,"Not a supported primitive #{invalid_element.inspect}")
    end
  end


  context 'when primitive is something else' do
    let(:primitive) { Object.new }

    it 'should raise error' do
      expect { subject }.to raise_error(ArgumentError,"Not a supported primitive #{primitive.inspect}")
    end
  end
end
