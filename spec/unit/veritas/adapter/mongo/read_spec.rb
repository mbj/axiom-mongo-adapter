require 'spec_helper'

describe Adapter::Mongo, '#read' do
  let(:object)    { described_class.new(database) }
  let(:database)  { mock('Database')              }
  let(:relation)  { mock('Relation')              }
  let(:query)     { mock('Query', :each => mock)  }
  let(:tuples)    { [ [1], [2] ]                  }
  let(:yields)    { []                            }

  before do
    Adapter::Mongo::Query.stub(:new => tuples)
  end

  context 'with a block' do
    subject { object.read(relation) { |row| yields << row } }

    it_should_behave_like 'a command method'

    it 'yields each tuple' do
      expect { subject }.to change { yields.dup }.
        from([]).
        to(tuples)
    end

    it 'initializes a query' do
      described_class::Query.should_receive(:new).with(database, relation).and_return(query)
      subject
    end
  end

  context 'without a block' do
    subject { object.read(relation) }

    it { should be_instance_of(to_enum.class) }
  end
end

