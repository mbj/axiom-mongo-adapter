require 'spec_helper'

describe Adapter::Mongo::Visitor, '.new' do
  subject { object.new(relation) }

  let(:object)   { described_class }
  let(:relation) { BASE_RELATION   }

  it { should be_frozen }
end
