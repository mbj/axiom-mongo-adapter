require 'spec_helper'

describe Adapter::Mongo::Gateway,'#inspect' do
  subject { object.inspect }

  let(:object)   { described_class.new(adapter,relation) }
  let(:adapter)  { mock('Adapter') }
  let(:relation) { mock('Realtion') }

  it 'should return GATEWAY' do
    should == 'GATEWAY'
  end
end
