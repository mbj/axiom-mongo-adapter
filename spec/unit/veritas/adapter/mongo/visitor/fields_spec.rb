require 'spec_helper'

describe Adapter::Mongo::Visitor,'#fields' do
  subject { object.fields }

  let(:object) { described_class.new(relation) }

  let(:base_relation) { BASE_RELATION }
  let(:header)        { base_relation.header }

  context 'on a base relation' do
    let(:relation) { base_relation }

    it 'should return fields from header' do
      should == header.map(&:name)
    end

    it_should_behave_like 'an idempotent method'
  end

  context 'on a wrapped base relation' do
    let(:relation) { base_relation.restrict(:id => 1) }

    it 'should return fields from header' do
      should == header.map(&:name)
    end

    it_should_behave_like 'an idempotent method'
  end

  context 'when some fields where removed' do
    before do
      pending
    end

    let(:relation) { base_relation.remove([:name]) }

    it 'should return remaining fields' do
      should == [:id]
    end

    it_should_behave_like 'an idempotent method'
  end
end
