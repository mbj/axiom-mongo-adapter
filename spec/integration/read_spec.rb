require 'spec_helper'
require 'logger'

describe Adapter::Mongo, 'read' do
  let(:uri)           { ENV.fetch('MONGO_URI', 'mongodb://localhost')                          }
  let(:logger)        { Logger.new($stdout)                                                   }
          
  let(:adapter)       { Adapter::Mongo.new(database)                                          }
  let(:base_relation) { Relation::Base.new('people', [[:firstname,String],[:lastname,String]]) }

  let(:connection)    { Mongo::Connection.new(uri)                                            }
                                                                                  
  let(:relation)      { Adapter::Mongo::Gateway.new(adapter, base_relation)                    }
  let(:database)      { connection.db('test')                                                 }
  let(:collection)    { database.collection('people')                                         }

  before :all do
    collection.insert(:firstname => 'John', :lastname => 'Doe')
    collection.insert(:firstname => 'Sue', :lastname => 'Doe')
  end

  specify 'it allows to receive all records' do
    data = relation.to_a
    data.should == [
      [ 'John', 'Doe' ],
      [ 'Sue', 'Doe' ]
    ]
  end

  specify 'it allows to receive specific records' do
    data = relation.restrict { |r| r.firstname.eq('John') }.to_a
    data.should == [ [ 'John', 'Doe' ] ]
  end
end
