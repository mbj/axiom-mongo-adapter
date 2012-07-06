require 'spec_helper'

describe Adapter::Mongo::Visitor,'#query' do
  subject { object.query }

  let(:object) { described_class.new(relation) }

  let(:base_relation) { BASE_RELATION }

  let(:factory) { Algebra::Restriction }

  context 'with base relation' do
    let(:relation) { base_relation }

    it { should == {} }
  end

  context 'with equality restriction' do
    let(:relation) { base_relation.restrict(:name => 'John')  }

    it { should == { :name => 'John' } }
  end

  context 'when restriction is present twice' do
    let(:relation) do 
      base_relation.restrict(:name => 'John').restrict(:id => 1)
    end

    it_should_behave_like 'a method visiting an unsupported component more than once'
  end
end
