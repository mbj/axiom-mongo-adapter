require 'spec_helper'

describe Adapter::Mongo::Visitor,'.new' do
  subject { object.new(relation) }

  let(:object)   { described_class }
  let(:relation) { Veritas::Relation::Base.new('collection_name',[[:id,Integer]]) }

  it { should be_frozen }
end
