require 'spec_helper'

describe Adapter::Mongo::Visitor,'#query' do
  subject { object.query }

  let(:object) { described_class.new(relation) }

  let(:base_relation) do
    Relation::Base.new(
      'collection_name',
      [[:id,Integer],[:firstname,String],[:lastname,String]]
    )
  end

  context 'with base relation' do
    let(:relation) { base_relation }

    it { should == {} }
  end

  context 'with equality restriction' do
    let(:relation) { base_relation.restrict(:firstname => 'John')  }

    it { should == { :firstname => 'John' } }
  end
end
