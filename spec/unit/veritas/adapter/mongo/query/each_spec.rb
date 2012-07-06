require 'spec_helper'

describe Adapter::Mongo::Query,'#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:object)          { described_class.new(database,relation)      }
  let(:relation)        { mock('Relation')                            }
  let(:collection)      { mock('Collection')                          }
  let(:database)        { mock('Database', :collection => collection) }
  let(:collection_name) { 'name'                                      }
  let(:yields)          { []                                          }

  let(:query)           { mock('Query')                               }
  let(:skip)            { mock('Skip')                                }
  let(:limit)           { mock('Limit')                               }
  let(:fields)          { [:id,:name]                                 }

  let(:documents)       { [{'id'=> 1, 'name' => 'Alice'}, { 'id' => 2, 'name' => 'Bob' }] }

  before do
    collection.stub(:find => documents)
    Adapter::Mongo::Visitor.stub(:new => visitor)
  end

  let(:visitor) do
    mock('Visitor', 
      :collection_name => collection_name,
      :query           => query,
      :options         => options,
      :fields          => fields
    )
  end

  let(:options) do
    {
      :limit  => limit,
      :fields => fields,
      :skip   => skip,
      :fields => fields
    }
  end

  it_should_behave_like 'an #each method'

  it 'should create collection with correct name' do
    database.should_receive(:collection).with(collection_name).and_return(collection)
    subject
  end

  it 'should query the collection correctly' do
    collection.should_receive(:find).with(query,options).and_return(documents)
    subject
  end

  it 'yields each tuple' do
    expect { subject }.to change { yields.dup }.
      from([]).
      to([ [1,'Alice'], [2,'Bob'] ])
  end
end
