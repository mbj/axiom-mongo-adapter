require 'spec_helper'

describe Adapter::Mongo::Operations,'.new' do
  subject { object.new(map) }

  let(:object) { described_class }
  let(:map)    { mock('Map') }

  it { should be_kind_of(described_class) }
  it { should be_frozen }
end
