require 'spec_helper'

describe Adapter::Mongo::Operations, '#lookup' do
  subject { object.lookup(value) }

  let(:object) { described_class.new(map) }

  let(:map) do
    {
      Fixnum => :foo,
      Float => [:foo]
    }
  end

  context 'when values class is registred' do
    context 'and was registred as symbol' do
      let(:value) { 1 }

      it 'should return correct call' do
        should == [:foo,value]
      end
    end

    context 'and was registred as array' do
      let(:value) { 1.0 }

      it 'should return correct call' do
        should == [:foo,value]
      end
    end
  end

  context 'when values class is NOT registred' do
    let(:value) { // }

    it 'should raise error' do
      expect { subject }.to raise_error(Adapter::Mongo::UnsupportedAlgebraError,'No support for Regexp' )
    end
  end
end
