require 'spec_helper'

describe Adapter::Mongo::Visitor,'#options' do
  let(:response) { object.options }

  let(:object)        { described_class.new(relation) }
  let(:base_relation) { BASE_RELATION                 }

  context 'sort option' do
    subject { response.fetch(:sort) }

    let(:factory)       { Relation::Operation::Order    }

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

    context 'when sort operation is present twice' do
      let(:relation) do 
        base_relation.sort_by do |r| 
          [r.id.asc,r.name.desc]
        end.sort_by do |r|
          [r.id.asc,r.name.desc]
        end
      end

      it_should_behave_like 'a method visiting an unsupported component more than once'
    end
  end

  context 'limit option' do
    subject { response.fetch(:limit) }

    let(:factory) { Relation::Operation::Limit                          }
    let(:ordered) { base_relation.sort_by { |r| [r.id.asc,r.name.asc] } }

    context 'with base relation' do
      let(:relation) { base_relation }

      it { should be(nil) }
    end

    context 'with limit operation' do
      let(:relation) { ordered.take(10) }

      it { should be(10) }
    end

    context 'with nested limit operation' do
      let(:relation) { ordered.take(10).take(10) }

      it_should_behave_like 'a method visiting an unsupported component more than once'
    end
  end

  context 'skip option' do
    subject { response.fetch(:skip) }

    let(:factory) { Relation::Operation::Offset }

    let(:ordered) { base_relation.sort_by { |r| [r.id.asc,r.name.asc] } }
    let(:base_relation) { BASE_RELATION }

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
end
