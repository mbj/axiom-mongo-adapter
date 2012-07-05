require 'spec_helper'

describe Adapter::Mongo::Visitor,'#collection_name' do
  subject { object.collection_name }

  let(:object)        { described_class.new(relation)              }
  let(:base_relation) { Relation::Base.new('name',[[:id,Integer]]) }

  context 'when base relation is passed' do
    let(:relation) { base_relation }

    it 'should return relation base name' do
      should be(base_relation.name)
    end

    it_should_behave_like 'an idempotent method'
  end

  context 'when base relation is wrapped into operations' do
    let(:relation) { base_relation.restrict(:id => 1) }

    it 'should return relation base name' do
      should be(base_relation.name)
    end

    it_should_behave_like 'an idempotent method'
  end
end
