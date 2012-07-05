require 'spec_helper'

describe Adapter::Mongo::Visitor,'#limit' do
  subject { object.limit }

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
    let(:relation) { ordered.take(10) }

    it { should be(10) }
  end
end
