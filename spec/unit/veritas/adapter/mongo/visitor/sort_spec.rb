require 'spec_helper'

describe Adapter::Mongo::Visitor,'#sort' do
  subject { object.sort }

  let(:object)        { described_class.new(relation)                             }
  let(:base_relation) { Relation::Base.new('name',[[:id,Integer],[:name,String]]) }

  context 'when visiting base relation' do
    let(:relation) { base_relation }

    it_should_behave_like 'an idempotent method'

    it { should == [] }
  end

  context 'when visiting sorted relation' do
    let(:relation) { base_relation.sort_by { |r| [r.id.asc,r.name.desc] } }

    it { should == [[:id,Mongo::ASCENDING],[:name,Mongo::DESCENDING]] }

    it_should_behave_like 'an idempotent method'
  end
end
