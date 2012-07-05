require 'spec_helper'

describe Adapter::Mongo::Literal,'#attribute_name' do
  subject { object.attribute_name(attribute) }

  let(:object)    { Adapter::Mongo::Literal }
  let(:attribute) { mock('Attribute', :name => name) }

  context 'when name is a Symbol' do
    let(:name) { :foo }
    it { should be(name) }

    it_should_behave_like 'an idempotent method'
  end

  context 'when name is something else' do
    let(:name) { Object.new }

    it 'should raise error' do
      expect { subject }.to raise_error(ArgumentError,"Not a supported key #{name.inspect}")
    end
  end
end
