# encoding: utf-8

require 'spec_helper'

describe Adapter::Mongo::Gateway, '#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:header)   { Relation::Header.coerce([[:id, Integer]]) }
  let(:reader)   { mock('Reader')                            }
  let(:tuple)    { Tuple.coerce(header, [1])                 }
  let(:adapter)  { mock('Adapter')                           }
  let!(:object)  { described_class.new(adapter, relation)    }
  let(:yields)   { []                                        }

  context 'with an unmaterialized relation' do
    let(:relation) { Relation::Base.new('name', header) }
    let(:is_materialized) { false }

    before do
      adapter.stub(:read => [tuple])
    end

    it_should_behave_like 'an #each method'

    it 'yields each tuple' do
      expect { subject }.to change { yields.dup }.from([]).to([ tuple ])
    end

    it 'passes in the relation to the adapter reader' do
      adapter.should_receive(:read).with(relation)
      subject
    end
  end

  context 'with a materialized relation' do
    let(:relation) { Relation.new(header, [ tuple ]) }

    it_should_behave_like 'an #each method'

    it 'yields each tuple' do
      expect { subject }.to change { yields.dup }.from([]).to([ tuple ])
    end
  end
end
