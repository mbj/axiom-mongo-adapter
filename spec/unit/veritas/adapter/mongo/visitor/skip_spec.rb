require 'spec_helper'

describe Adapter::Mongo::Visitor,'#skip' do
  subject { object.skip }

  let(:object) { described_class.new(relation) }

  let(:base_relation) do
    Relation::Base.new('name',[[:id,Integer],[:name,String]])
  end

  let(:ordered) { base_relation.sort_by { |r| [r.id.asc,r.name.asc] } }

  context 'with base relation' do
    let(:relation) { base_relation }

    it { should be(nil) }
  end

  context 'with limit operation' do
    let(:relation) { ordered.drop(10) }

    it { should be(10) }
  end

  context 'with nested limit operation' do
    let(:relation) { ordered.drop(10).drop(10) }

    it_should_behave_like 'a method visiting an unsupported component more than once'
  end
end
