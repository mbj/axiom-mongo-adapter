require 'spec_helper'

describe Adapter::Mongo,'.new' do
  subject { object.new(database) }

  let(:object) { described_class }

  let(:database) { mock(Mongo::DB) }

  it { should be_frozen }
end
