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

  context 'when restriction is present twice' do
    let(:relation) do 
      base_relation.restrict(:firstname => 'John').restrict(:lastname => 'Doe')
    end

    it 'should raise error' do
      expect { subject }.to 
        raise_error(Adapter::Mongo::UnsupportedAlgebraError,"No support for visiting: #{described_class} more than once")
    end
  end
end
